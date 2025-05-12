#!/bin/bash

RELOAD=false

# Handle CLI flags
for arg in "$@"; do
  case $arg in
    --reload)
      RELOAD=true
      shift
      ;;
  esac
done

function wait_for_falco() {
  echo "[*] Waiting for Falco daemonset to be ready..."
  kubectl rollout status daemonset falco -n falco || { echo "❌ Falco not ready"; exit 1; }
}

function check_logs() {
  KEYWORD="$1"
  echo "[*] Validating keyword: $KEYWORD across all Falco pods..."
  ./lifecycle/check-falco-logs.sh "$KEYWORD"
}

if [ "$RELOAD" = true ]; then
  echo "[*] Reloading all Falco rules..."
  ./lifecycle/deploy-falco-rules.sh all
fi

while true; do
  clear
  echo "🧪 Runtime Detection Lab"
  echo "========================"
  echo "Choose a detection test:"
  echo
  echo "1) Falco: TOCTOU Detection (Syscall)"
  echo "2) Falco: RBAC Misuse Detection (Audit Logs)"
  echo "3) KubeArmor: TOCTOU Block Enforcement"
  echo "4) Falco: Generic Write Debug Rule"
  echo "5) Reapply KubeArmor Policy"
  echo "6) View Logs"
  echo "7) Exit"
  echo

  read -p "Enter your choice [1-7]: " choice
  echo

  case $choice in
    1)
      wait_for_falco
      ./simulations/falco/toctou/simulate-detect.sh
      check_logs TOCTOU
      ;;
    2)
      wait_for_falco
      ./simulations/falco/rbac/simulate-rbac-abuse.sh
      check_logs secrets
      ;;
    3)
      echo "[*] Applying KubeArmor policy..."
      kubectl apply -f rules/kubearmor/toctou/toctou-configmap-block.yaml
      sleep 5
      ./simulations/kubearmor/toctou/simulate-block.sh
      ;;
    4)
      wait_for_falco
      ./simulations/falco/debug/simulate-generic-write.sh
      check_logs "TEST: Write"
      ;;
    5)
      kubectl apply -f rules/kubearmor/toctou/toctou-configmap-block.yaml
      echo "✅ Policy reapplied."
      ;;
    6)
      echo "📄 Log Viewer"
      echo "1) Falco Logs"
      echo "2) KubeArmor Logs"
      read -p "Choice: " log_choice
      case $log_choice in
        1) kubectl logs -n falco -l app.kubernetes.io/instance=falco --tail=100 ;;
        2) kubectl logs -n kubearmor -l kubearmor-app=kubearmor --tail=100 ;;
        *) echo "Invalid log choice." ;;
      esac
      ;;
    7)
      echo "👋 Exiting lab."
      exit 0
      ;;
    *)
      echo "Invalid choice."
      ;;
  esac

  echo
  read -p "Press Enter to return to main menu..."
done