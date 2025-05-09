#!/bin/bash

echo "[*] Merging all Falco rules from rules/falco/ into one custom rules file..."

# Combine all individual rule files into a single temp file
cat rules/falco/*.yaml > .falco-merged-rules.yaml

echo "[*] Applying merged rules via Helm..."
helm upgrade falco falcosecurity/falco -n falco \
  --set-file customRules.custom-rules.yaml=.falco-merged-rules.yaml

echo "✅ All custom Falco rules deployed."