#!/bin/bash

# 1. Create a ConfigMap
kubectl create configmap demo-config --from-literal=entry=original

# 2. Deploy a pod that mounts the ConfigMap
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: toctou-test
  labels:
    app: demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ["/bin/sh", "-c", "sleep 3600"]
    volumeMounts:
    - name: config
      mountPath: /mnt/configmap
  volumes:
  - name: config
    configMap:
      name: demo-config
EOF

echo "Waiting 5 seconds before modifying the ConfigMap file..."
sleep 5

# 3. Modify the mounted file inside the running container (simulating TOCTOU)
kubectl exec toctou-test -- sh -c "echo hacked > /mnt/configmap/entry"

echo "TOCTOU simulation complete. Check Falco logs or Sidekick outputs."