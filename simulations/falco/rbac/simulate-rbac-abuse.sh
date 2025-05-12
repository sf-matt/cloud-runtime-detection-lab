#!/bin/bash

echo "[*] Applying RBAC Role and ServiceAccount..."
kubectl apply -f simulations/falco/rbac/rbac-abuser-role.yaml

echo "[*] Creating RBAC simulation pod..."
kubectl delete pod rbac-abuse-test --ignore-not-found

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: rbac-abuse-test
  labels:
    app: demo-falco
spec:
  serviceAccountName: rbac-abuser
  containers:
  - name: abuse
    image: alpine
    command: ["sleep", "60"]
EOF

echo "[*] Waiting for pod to become ready..."
kubectl wait --for=condition=Ready pod/rbac-abuse-test --timeout=30s

echo "[*] Running API call from inside the pod..."
kubectl exec rbac-abuse-test -- sh -c '
  apk add --no-cache curl &&
  curl -s --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    https://kubernetes.default.svc/api/v1/secrets
'

echo "[*] Done."

echo "[*] Cleaning up..."
kubectl delete pod rbac-abuse-test --ignore-not-found
kubectl delete role rbac-abuse --ignore-not-found
kubectl delete rolebinding rbac-abuse-binding --ignore-not-found
kubectl delete serviceaccount rbac-abuser --ignore-not-found