#!/bin/bash

POD_NAME=debug-write-test

echo "[*] Deleting existing debug pod if any..."
kubectl delete pod $POD_NAME --ignore-not-found

echo "[*] Launching pod that will perform a basic write..."
kubectl run $POD_NAME \
  --image=busybox \
  --restart=Never \
  --labels=app=demo-falco \
  --command -- sleep 60

echo "[*] Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/$POD_NAME --timeout=30s

echo "[*] Writing to /tmp/debug.txt..."
kubectl exec $POD_NAME -- sh -c 'echo hello > /tmp/debug.txt'

echo "[*] Done. Check Falco logs for generic write detection."

echo "[*] Cleaning up..."
kubectl delete pod $POD_NAME --ignore-not-found