#!/bin/bash
echo "[*] Running TOCTOU block simulation (KubeArmor) — expect permission denied"

kubectl apply -f rules/kubearmor/toctou/toctou-configmap-block.yaml
echo "[*] Waiting for policy enforcement to activate..."
sleep 5

kubectl delete pod toctou-kubearmor-test --ignore-not-found

kubectl run toctou-kubearmor-test --image=busybox --restart=Never \
  --labels=app=demo-kubearmor \
  -- sh -c 'echo hacked > /mnt/configmap/entry'

kubectl logs toctou-kubearmor-test