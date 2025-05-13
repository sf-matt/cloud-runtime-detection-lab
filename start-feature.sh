#!/bin/bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: ./start-feature.sh <feature-name>"
  exit 1
fi

FEATURE_NAME="$1"
BRANCH_NAME="feature/$FEATURE_NAME"

echo "[*] Creating and checking out branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# Optionally create base folders
echo "[*] Scaffolding detection folders..."
mkdir -p rules/falco/$FEATURE_NAME
mkdir -p simulations/falco/$FEATURE_NAME
mkdir -p detections

echo "[*] Touching placeholder files..."
touch rules/falco/$FEATURE_NAME/${FEATURE_NAME}.yaml
touch simulations/falco/$FEATURE_NAME/simulate-${FEATURE_NAME}.sh
chmod +x simulations/falco/$FEATURE_NAME/simulate-${FEATURE_NAME}.sh

echo "# Placeholder" > detections/${FEATURE_NAME}.md

echo "✅ Branch and scaffold ready."