#!/bin/bash
echo "[*] Running TOCTOU detection simulation (Falco) — expect alert, not block"

# Clean up previous pod
kubectl delete pod toctou-falco-test --ignore-not-found

# Run pod with label for Falco
kubectl run toctou-falco-test --image=busybox --restart=Never --labels=app=demo-falco -- sh -c 'echo hacked > /mnt/configmap/entry'

# Check logs
echo "[*] Pod logs:"
kubectl logs toctou-falco-test