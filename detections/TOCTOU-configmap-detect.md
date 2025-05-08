# 🛡️ Detection: TOCTOU Privilege Escalation via ConfigMap

## 📖 Summary

This detection targets a Time-of-Check to Time-of-Use (TOCTOU) attack in Kubernetes where a `ConfigMap` or `Secret` is modified after a pod is defined but before it starts. The workload consumes the updated config at runtime—potentially leading to privilege escalation, logic injection, or unexpected behavior.

...

## 🧠 Detection Goals

- Alert on suspicious file writes to ConfigMaps mounted inside live containers
- Highlight behavior consistent with TOCTOU abuse
- Detect attacks before they escalate to lateral movement or breakout