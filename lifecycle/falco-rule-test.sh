#!/bin/bash
# 🚀 Redeploy Falco with the latest custom rule from the repo

helm upgrade falco falcosecurity/falco -n falco \
  --set-file customRules.custom-rules.yaml=rules/falco/toctou-configmap-detect.yaml

echo "✅ Falco rule updated and redeployed."