#!/bin/bash
echo "[*] Making all scripts executable..."

find lifecycle -name "*.sh" -exec chmod +x {} +
find simulations/falco -name "*.sh" -exec chmod +x {} +
find simulations/kubearmor -name "*.sh" -exec chmod +x {} +

echo "[*] Deploying all custom Falco rules..."
./lifecycle/deploy-falco-rules.sh all

echo "✅ Bootstrap complete."