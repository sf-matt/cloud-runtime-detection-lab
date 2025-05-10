# 🛡️ Detection Coverage

This document summarizes the runtime security detections implemented and validated in the lab.

---

## ✅ TOCTOU: ConfigMap Modification Attempt

**Description:**  
Detects an attempted Time-of-Check to Time-of-Use (TOCTOU) style attack where a container tries to write to a mounted Kubernetes ConfigMap.

**Tool:** Falco  
**Source:** Syscall (eBPF)  
**Rule File:** `rules/falco/toctou/toctou-configmap-detect.yaml`

**Test Script:**  
```bash
./simulations/falco/toctou/simulate-detect.sh
```

**MITRE ATT&CK:** T1611 (Escape), T1203 (Exploitation for Privilege Escalation)  
**Validation:** ✅ Detection confirmed on attempted write via `echo > /mnt/configmap/entry`

---

## ✅ RBAC Misuse: Unauthorized Kubernetes API Access

**Description:**  
Detects an attacker using a compromised service account to list or read Kubernetes secrets they should not have access to.

**Tool:** Falco  
**Source:** Kubernetes Audit Logs  
**Rule File:** `rules/falco/rbac/rbac-api-misuse-audit.yaml`

**Test Script:**  
```bash
./simulations/falco/rbac/simulate-rbac-abuse.sh
```

**MITRE ATT&CK:** T1078.004 (Valid Accounts: Cloud Accounts), T1087 (Account Discovery)  
**Validation:** ✅ Detection confirmed via audit log on forbidden API call to list secrets

---

## 🧪 Debug Rule

A generic debug rule is available for validating Falco syscall visibility:

**Rule:** `rules/falco/debug/test-write-syscall.yaml`  
**Usage:** Included during troubleshooting or development.