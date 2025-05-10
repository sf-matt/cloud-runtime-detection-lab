# 🔐 TOCTOU Detection: ConfigMap Modification Attempt

## 🧠 Scenario

An attacker attempts to exploit a Time-of-Check to Time-of-Use (TOCTOU) vulnerability by modifying a Kubernetes ConfigMap volume mounted inside a container. Although the volume is read-only by default, a misconfigured setup or attempted exploit is still detectable at the syscall level.

## 🛠 Tool: Falco

- **Source:** Syscall
- **Detection Method:** eBPF-based monitoring of write attempts to `/mnt/configmap`
- **Rule File:** `rules/falco/toctou/toctou-configmap-detect.yaml`

### Falco Rule Highlights
```yaml
evt.type in (open, openat, openat2) and
evt.is_open_write = true and
fd.name startswith "/mnt/configmap"
```

## 🧪 Simulation

**Script:** `./simulations/falco/toctou/simulate-detect.sh`  
**Action:** Attempted write via `echo hacked > /mnt/configmap/entry`

Expected log output:
```
TOCTOU ConfigMap modification attempt detected by sh (...) opening file /mnt/configmap/entry
```

## ✅ Validation

- Confirmed detection using a writable simulation pod and valid Falco config (`-A` flag enabled).
- Rule fires on attempted write even if the operation fails (e.g. read-only mount).

## 🧩 MITRE ATT&CK Mapping

- **T1611** – Escape to Host
- **T1203** – Exploitation for Privilege Escalation