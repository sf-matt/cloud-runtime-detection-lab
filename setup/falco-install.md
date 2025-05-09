# 🛠️ Falco Setup Guide (Helm-based)

This guide walks you through installing Falco, adding custom detection rules (like TOCTOU), and verifying that detections are working.

---

## 🚀 Step 1: Install Falco via Helm

The easiest way to get Falco running on Kubernetes is with the official Helm chart.

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco -n falco --create-namespace
```

This deploys Falco as a DaemonSet with default rules.

---

## 🧪 Step 2: Verify Falco is Working

Run a known detection to confirm Falco sees syscalls.

```bash
kubectl run falco-test --image=busybox -- sleep 3600
kubectl exec falco-test -- sh -c "echo test > /etc/falco-test"
```

Then check logs:

```bash
kubectl logs -l app.kubernetes.io/name=falco -n falco | grep /etc
```

You should see an alert like:
```
Write below /etc detected (user=root ...)
```

---

## ✍️ Step 3: Add a Custom Falco Rule (TOCTOU)

Create or edit a `falco-values.yaml` file with the following:

```yaml
customRules:
  custom_toctou_rule.yaml: |-
    - rule: TOCTOU ConfigMap Modification Detected
      desc: Detects writable file opens in ConfigMap mount paths (TOCTOU behavior)
      condition: >
        (evt.type in (open, openat, openat2) and
         evt.is_open_write = true and
         fd.name startswith "/mnt/configmap" and
         proc.name = sh) and
        container
      output: "TOCTOU ConfigMap modification detected by %proc.name (user=%user.name, container=%container.id) on file %fd.name"
      priority: WARNING
      tags: [k8s, configmap, toctou, runtime]
      enabled: true
```

Then upgrade your Falco install:

```bash
helm upgrade falco falcosecurity/falco -n falco -f falco-values.yaml
```

---

## 🧼 Step 4: Clean Up (Optional)

```bash
kubectl delete pod falco-test
```

---

## ✅ Next Step: Run Your Detection Simulation

Once Falco is configured and the rule is live, you can run:

```bash
./simulations/simulate-toctou-detect.sh
```

Then tail Falco logs:

```bash
kubectl logs -l app.kubernetes.io/name=falco -n falco -f | grep TOCTOU
```

You should see alerts like:

```
TOCTOU ConfigMap modification detected by sh (user=root ...) on file /mnt/configmap/entry
```

If you don’t, revisit the `fd.name` path, or relax the rule conditions (e.g., drop `proc.name`).