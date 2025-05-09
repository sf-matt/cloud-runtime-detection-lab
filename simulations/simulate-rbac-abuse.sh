#!/bin/bash
echo "[*] Applying RBAC Role and ServiceAccount..."
kubectl apply -f rbac-abuser-role.yaml

echo "[*] Waiting for ServiceAccount to be ready..."
for i in {1..10}; do
  kubectl get serviceaccount rbac-abuser > /dev/null 2>&1 && break
  echo "  ...waiting..."
  sleep 2
done

if ! kubectl get serviceaccount rbac-abuser > /dev/null 2>&1; then
  echo "❌ ServiceAccount 'rbac-abuser' not ready after timeout"
  exit 1
fi

echo "[*] Running RBAC simulation pod..."
kubectl delete pod rbac-abuse-test --ignore-not-found

kubectl run rbac-abuse-test \
  --image=alpine \
  --restart=Never \
  --labels=app=demo-falco \
  --serviceaccount=rbac-abuser \
  -- sh -c \
  "apk add --no-cache curl && curl -s --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  -H 'Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)' \
  https://kubernetes.default.svc/api/v1/secrets"

echo "[*] Done. Check Falco logs for detections."