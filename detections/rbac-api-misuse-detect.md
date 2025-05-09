# 🔍 RBAC API Misuse Detection (Falco)

This detection identifies a containerized process abusing its service account to access the Kubernetes API inappropriately (e.g., reading secrets).

## Status: In Progress

- [ ] RBAC setup
- [ ] Simulation script
- [ ] Detection rule
- [ ] Outcome documentation
---

## 🎯 Why This Matters

This detection demonstrates how a containerized workload can misuse its Kubernetes service account to access sensitive resources—specifically, retrieving secrets via the API server. 

It proves that:
- RBAC misconfigurations are not just theoretical risks—they can be exploited from within a running pod.
- Detection tools like Falco can surface **real API abuse** in progress, not just static over-permissioned roles.
- This bridges the gap between **IAM modeling** and **runtime visibility**—a key skill in modern platform security.