#!/bin/bash

while true; do
  clear
  echo "🧪 Cloud Runtime Detection Lab Test Runner"
  echo "Select a test to run:"
  echo "1) TOCTOU (Falco Detection)"
  echo "2) TOCTOU (KubeArmor Block)"
  echo "3) RBAC API Misuse (Falco Detection)"
  echo "4) Exit"
  echo

  read -p "Enter your choice [1-4]: " choice
  echo

  case $choice in
    1)
      echo "[*] Running TOCTOU detection test (Falco)..."
      ./lifecycle/deploy-falco-rules.sh
      ./simulations/simulate-toctou-detect.sh
      echo "[*] Checking Falco logs..."
      if kubectl logs -n falco -l app=falco --tail=100 | grep -q "TOCTOU"; then
        echo "✅ Detection succeeded"
      else
        echo "❌ No detection found"
      fi
      ;;
    2)
      echo "[*] Running TOCTOU block test (KubeArmor)..."
      kubectl apply -f rules/kubearmor/toctou-configmap-block.yaml
      ./simulations/simulate-toctou-block.sh
      echo "[*] Checking KubeArmor logs..."
      if kubectl logs -n kubearmor -l kubearmor-app=kubearmor --tail=100 | grep -q "mnt/configmap"; then
        echo "✅ Block enforced"
      else
        echo "❌ Block not detected"
      fi
      ;;
    3)
      echo "[*] Running RBAC API misuse test (Falco)..."
      ./lifecycle/deploy-falco-rules.sh
      kubectl apply -f rbac-abuser-role.yaml
      ./simulations/simulate-rbac-abuse.sh
      echo "[*] Checking Falco logs..."
      if kubectl logs -n falco -l app=falco --tail=100 | grep -qi "rbac"; then
        echo "✅ Detection succeeded"
      else
        echo "❌ No detection found"
      fi
      ;;
    4)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid choice."
      ;;
  esac

  echo
  read -p "Press Enter to return to menu..."
done