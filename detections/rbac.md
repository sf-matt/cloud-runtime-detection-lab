# 🔐 RBAC Misuse Detection: Unauthorized Secrets Access

## 🧠 Scenario

An attacker leverages a misconfigured Kubernetes RoleBinding or compromised service account to attempt access to Kubernetes secrets via the API.

## 🛠 Tool: Falco

- **Source:** Kubernetes Audit Logs (`k8s_audit`)
- **Detection Method:** Monitors for API responses with `"Forbidden"` errors on sensitive resource types
- **Rule File:** `rules/falco/rbac/rbac-api-misuse-audit.yaml`

### Falco Rule Highlights
```yaml
jevt.value.error = "Forbidden" and
jevt.value.kind = "secrets" and
jevt.value.verb in (get, list)
```

## 🧪 Simulation

**Script:** `./simulations/falco/rbac/simulate-rbac-abuse.sh`  
**Action:** API call from a service account with insufficient permissions

Expected log output:
```
RBAC API misuse detected: user=system:serviceaccount:... verb=list resource=secrets
```

## ✅ Validation

- Confirmed detection using dynamic audit log backend.
- Rule fired on 403 Forbidden response to API request for secrets.

## 🧩 MITRE ATT&CK Mapping

- **T1078.004** – Valid Accounts: Cloud Accounts
- **T1087** – Account Discovery