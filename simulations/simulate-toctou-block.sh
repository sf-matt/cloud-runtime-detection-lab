#!/bin/bash
echo "[*] Running TOCTOU block simulation (KubeArmor) — expect permission denied"

# Apply KubeArmor policy and wait for enforcement to attach
echo "[*] Applying KubeArmor policy..."
kubectl apply -f rules/kubearmor/toctou-configmap-block.yaml
echo "[*] Waiting for enforcement to activate..."
sleep 5

# Clean up previous pod
kubectl delete pod toctou-kubearmor-test --ignore-not-found

# Run pod with isolated label
kubectl run toctou-kubearmor-test --image=busybox --restart=Never --labels=app=demo-kubearmor -- sh -c 'echo hacked > /mnt/configmap/entry'

# Check output
echo "[*] Pod logs:"
kubectl logs toctou-kubearmor-test