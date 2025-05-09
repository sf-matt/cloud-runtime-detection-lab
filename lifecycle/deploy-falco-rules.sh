#!/bin/bash

MODULE=$1

if [ -z "$MODULE" ]; then
  echo "❌ Usage: $0 <module-name | all>"
  echo "Available modules: toctou, rbac, all"
  exit 1
fi

if [ "$MODULE" = "all" ]; then
  echo "[*] Merging all Falco rules across all modules..."
  find rules/falco -name "*.yaml" -exec echo "---" \; -exec cat {} \; > .falco-all-rules.yaml
  TARGET_FILE=".falco-all-rules.yaml"
else
  RULE_DIR="rules/falco/$MODULE"

  if [ ! -d "$RULE_DIR" ]; then
    echo "❌ No such module directory: $RULE_DIR"
    exit 1
  fi

  echo "[*] Merging rules for module '$MODULE'..."
  find "$RULE_DIR" -name "*.yaml" -exec echo "---" \; -exec cat {} \; > ".falco-${MODULE}-rules.yaml"
  TARGET_FILE=".falco-${MODULE}-rules.yaml"
fi

echo "[*] Upgrading Falco..."
if helm upgrade falco falcosecurity/falco -n falco \
  --set-file customRules.customRules="$TARGET_FILE" > /dev/null 2>&1; then
  echo "✅ Falco rules for '$MODULE' deployed successfully."
  echo "[*] Waiting 10 seconds for rules to load..."
  sleep 10
else
  echo "❌ Failed to upgrade Falco. Check your Helm deployment."
  exit 1
fi