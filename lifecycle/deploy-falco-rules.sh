#!/bin/bash

MODULE=$1

if [ -z "$MODULE" ]; then
  echo "❌ Usage: $0 <module-name>"
  echo "Available modules: toctou, rbac"
  exit 1
fi

RULE_DIR="rules/falco/$MODULE"

if [ ! -d "$RULE_DIR" ]; then
  echo "❌ No such module directory: $RULE_DIR"
  exit 1
fi

echo "[*] Merging rules for module '$MODULE'..."
find "$RULE_DIR" -name "*.yaml" -exec echo "---" \; -exec cat {} \; > ".falco-${MODULE}-rules.yaml"

echo "[*] Deploying merged rules to Falco..."
helm upgrade falco falcosecurity/falco -n falco \
  --set-file customRules.customRules=".falco-${MODULE}-rules.yaml"

echo "✅ Falco rules for '$MODULE' deployed."