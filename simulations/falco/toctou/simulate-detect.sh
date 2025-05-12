#!/bin/bash

echo "[*] Creating dummy ConfigMap..."
kubectl create configmap dummy-config --from-literal=entry="test" --dry-run=client -o yaml | kubectl apply -f -

echo "[*] Deleting old simulation pod if it exists..."
kubectl delete pod toctou-falco-test --ignore-not-found

echo "[*] Launching new pod with /mnt/configmap mount..."
kubectl run toctou-falco-test \
  --image=busybox \
  --restart=Never \
  --labels=app=demo-falco \
  --overrides='
{
  "apiVersion": "v1",
  "spec": {
    "containers": [{
      "name": "demo",
      "image": "busybox",
      "command": ["sh", "-c", "sleep 60"],
      "volumeMounts": [{
        "name": "cfg",
        "mountPath": "/mnt/configmap"
      }]
    }],
    "volumes": [{
      "name": "cfg",
      "configMap": {
        "name": "dummy-config"
      }
    }]
  }
}' \
  --command

echo "[*] Waiting for pod to become ready..."
kubectl wait --for=condition=Ready pod/toctou-falco-test --timeout=30s

echo "[*] Executing write to /mnt/configmap/entry..."
kubectl exec toctou-falco-test -- sh -c 'echo hacked > /mnt/configmap/entry'

echo "[*] Done."

echo "[*] Cleaning up..."
kubectl delete pod toctou-falco-test --ignore-not-found
kubectl delete configmap dummy-config --ignore-not-found