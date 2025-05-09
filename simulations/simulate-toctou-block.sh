#!/bin/bash
echo "[*] Running TOCTOU block simulation (expect: permission denied)"

# Clean up any previous run
kubectl delete pod toctou-test --ignore-not-found

# Recreate the pod and attempt the TOCTOU-style write
kubectl run toctou-test --image=busybox --restart=Never --labels=app=demo -- sh -c 'echo hacked > /mnt/configmap/entry'

# Show the logs to verify enforcement
echo "[*] Pod logs:"
kubectl logs toctou-test