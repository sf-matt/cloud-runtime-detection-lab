#!/bin/bash

function wait_for_falco() {
  echo "[*] Waiting for Falco to be ready..."
  kubectl rollout status daemonset falco -n falco || { echo "❌ Falco not ready"; exit 1; }
}

while true; do
  clear
  echo "🧪 Runtime Detection Lab"
  echo "Choose what to test:"
  echo
  echo "1) Falco Detections"
  echo "2) KubeArmor Policies"
  echo "3) View Logs"
  echo "4) Exit"
  echo

  read -p "Enter your choice [1-4]: " main_choice
  echo

  case $main_choice in
    1)
      while true; do
        echo "📦 Falco Detections"
        echo "1) TOCTOU Detection"
        echo "2) RBAC API Misuse Detection"
        echo "3) Back"
        echo
        read -p "Enter your choice [1-3]: " falco_choice
        echo

        case $falco_choice in
          1)
            ./lifecycle/deploy-falco-rules.sh toctou
            wait_for_falco
            ./simulations/simulate-toctou-detect.sh
            if kubectl logs -n falco -l app=falco --tail=100 | grep -q "TOCTOU"; then
              echo "✅ TOCTOU detection succeeded"
            else
              echo "❌ TOCTOU detection not found"
            fi
            ;;
          2)
            ./lifecycle/deploy-falco-rules.sh rbac
            wait_for_falco
            ./simulations/simulate-rbac-abuse.sh
            if kubectl logs -n falco -l app=falco --tail=100 | grep -qi "rbac"; then
              echo "✅ RBAC misuse detection succeeded"
            else
              echo "❌ RBAC detection not found"
            fi
            ;;
          3)
            break
            ;;
          *)
            echo "Invalid choice."
            ;;
        esac
        echo
        read -p "Press Enter to return to Falco menu..."
      done
      ;;
    2)
      while true; do
        echo "🛡️ KubeArmor Policies"
        echo "1) TOCTOU Block Enforcement"
        echo "2) Reapply TOCTOU Policy Only"
        echo "3) Back"
        echo
        read -p "Enter your choice [1-3]: " kube_choice
        echo

        case $kube_choice in
          1)
            kubectl apply -f rules/kubearmor/toctou-configmap-block.yaml
            echo "[*] Waiting for policy to take effect..."
            sleep 5
            ./simulations/simulate-toctou-block.sh
            ;;
          2)
            kubectl apply -f rules/kubearmor/toctou-configmap-block.yaml
            echo "✅ Policy reapplied."
            ;;
          3)
            break
            ;;
          *)
            echo "Invalid choice."
            ;;
        esac
        echo
        read -p "Press Enter to return to KubeArmor menu..."
      done
      ;;
    3)
      while true; do
        echo "📄 Log Viewer"
        echo "1) Tail Falco Logs"
        echo "2) Tail KubeArmor Logs"
        echo "3) Back"
        echo
        read -p "Enter your choice [1-3]: " log_choice
        echo

        case $log_choice in
          1)
            kubectl logs -n falco -l app=falco --tail=100
            ;;
          2)
            kubectl logs -n kubearmor -l kubearmor-app=kubearmor --tail=100
            ;;
          3)
            break
            ;;
          *)
            echo "Invalid choice."
            ;;
        esac
        echo
        read -p "Press Enter to return to Log Viewer..."
      done
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
done