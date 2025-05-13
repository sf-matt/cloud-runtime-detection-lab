#!/bin/bash
echo "[*] Making all scripts executable..."
chmod +x test-lab*.sh
chmod +x lifecycle/*.sh 2>/dev/null
chmod +x simulations/**/*.sh 2>/dev/null
chmod +x simulations/*/*.sh 2>/dev/null

echo "[*] Deploying all custom Falco rules..."
./lifecycle/deploy-falco-rules.sh all

echo "✅ Bootstrap complete."
