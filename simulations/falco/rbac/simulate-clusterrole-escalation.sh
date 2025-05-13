#!/bin/bash
set -euo pipefail

echo "[*] Creating rbac-abuser ServiceAccount..."
kubectl create serviceaccount rbac-abuser --dry-run=client -o yaml | kubectl apply -f -

echo "[*] Creating ClusterRoleBinding to grant permissions..."
kubectl create clusterrolebinding abuser-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=default:rbac-abuser \
  --dry-run=client -o yaml | kubectl apply -f -

echo "[*] Cleaning up previous resources..."
kubectl delete clusterrolebinding fake-binding --ignore-not-found=true
kubectl delete pod clusterrole-test --ignore-not-found=true

echo "[*] Deploying test pod..."
kubectl apply -f simulations/falco/rbac/clusterrole-test.yaml

echo "[*] Done. You can check Falco logs to confirm detection."