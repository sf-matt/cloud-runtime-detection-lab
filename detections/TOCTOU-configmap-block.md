# 🔐 Prevention: Blocking TOCTOU ConfigMap Abuse with KubeArmor

## 📖 Summary

This policy prevents TOCTOU-style attacks by **denying write access** to Kubernetes ConfigMap mount paths from inside a container.

...

## ✅ Why It Matters

Unlike Falco, which detects post-event, this policy enforces protection **before** the attack succeeds. Together, they form a defense-in-depth model:

- **Falco:** Detects config write after it happens  
- **KubeArmor:** Blocks the write before it succeeds