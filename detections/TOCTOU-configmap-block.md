# 🔐 TOCTOU ConfigMap Block (KubeArmor)

This enforcement rule prevents runtime modification of mounted ConfigMap files—closing the TOCTOU (Time-of-Check to Time-of-Use) window demonstrated in the companion Falco detection.

---

## 📜 Rule Summary

- **Target Path:** `/mnt/configmap/`
- **Enforcement Tool:** KubeArmor
- **Effect:** Blocks container processes from writing to the directory

---

## ✅ KubeArmor Policy

```yaml
apiVersion: security.kubearmor.com/v1
kind: KubeArmorPolicy
metadata:
  name: block-configmap-write
  namespace: default
spec:
  severity: 4
  message: "TOCTOU prevention: Block write access to ConfigMap directory"
  selector:
    matchLabels:
      app: demo
  file:
    matchDirectories:
      - dir: /mnt/configmap/
        recursive: true
  action: Block
```

---

## 🧪 Simulation Script

Use the following script to test KubeArmor's enforcement:

```
./simulations/simulate-toctou-block.sh
```

Expected result:
```
sh: can't create /mnt/configmap/entry: Permission denied
```

---

## 📊 Outcome Summary

| Element            | Detail                                       |
|--------------------|----------------------------------------------|
| Technique Prevented | TOCTOU-style ConfigMap tampering             |
| Enforcement Method | KubeArmor (via BPF-based syscall blocking)   |
| Runtime Impact     | Container is unable to write to config mount |
| Compared to Falco  | Falco detects after the fact; KubeArmor blocks in real time |

---

## 📁 Related

- [TOCTOU Detection (Falco)](TOCTOU-configmap-detect.md)
- [Simulation Script](../simulations/simulate-toctou-block.sh)
- [KubeArmor Policy](../rules/kubearmor/toctou-configmap-block.yaml)