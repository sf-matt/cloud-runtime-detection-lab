#!/bin/bash

echo "[*] Merging all Falco rules from rules/falco/ with proper YAML separators..."

# Combine all individual rule files into a single temp file with separators
find rules/falco -name "*.yaml" -exec echo "---" \; -exec cat {} \; > .falco-merged-rules.yaml

echo "[*] Applying merged rules via Helm..."
helm upgrade falco falcosecurity/falco -n falco \
  --set-file customRules.customRules=.falco-merged-rules.yaml

echo "✅ All custom Falco rules deployed."