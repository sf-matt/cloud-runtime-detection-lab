# ☁️ Cloud Runtime Detection Lab

This repo demonstrates how to build, simulate, and document real-world Kubernetes runtime security detections using Falco and KubeArmor.

---

## 🎯 Purpose

- Write and test custom Falco detection rules
- Block known techniques with KubeArmor policies
- Simulate attacks like TOCTOU (Time-of-Check to Time-of-Use) and RBAC abuse
- Build reusable, modular threat detection bundles
- Document outcomes for learning, visibility, and credibility

---

## 📁 Detection Modules and Layout

```bash
.
├── README.md
├── detections/
│   ├── TOCTOU-configmap-block.md
│   ├── TOCTOU-configmap-detect.md
│   ├── TOCTOU-outcome.md
│   └── rbac-api-misuse-detect.md
├── lifecycle/
│   ├── deploy-falco-rules.sh
│   └── test-lab.sh
├── rules/
│   ├── falco/
│   │   ├── toctou-configmap-detect.yaml
│   │   └── rbac-api-misuse-detect.yaml
│   └── kubearmor/
│       └── toctou-configmap-block.yaml
├── setup/
│   ├── falco-install.md
│   └── lab.md
├── simulations/
│   ├── simulate-toctou-block.sh
│   ├── simulate-toctou-detect.sh
│   └── simulate-rbac-abuse.sh
├── threat-models/                # (to be added)
└── rbac-abuser-role.yaml
```

---

## 🧪 Detection & Enforcement Scenarios

- **TOCTOU: ConfigMap Modification**
  - Falco detects unauthorized write attempts to `/mnt/configmap`
  - KubeArmor blocks those writes at runtime
  - Simulation script triggers the event for both tools
  - [View Detection Doc](detections/TOCTOU-configmap-detect.md)
  - [View Block Doc](detections/TOCTOU-configmap-block.md)

- **RBAC API Misuse**
  - Pod with excessive permissions accesses the K8s API
  - Falco detects runtime access to secrets via token + curl
  - [View Detection Doc](detections/rbac-api-misuse-detect.md)

---

## 🧪 Test-Driven Detection Development (TDDD)

Each detection rule in this repo is paired with:

- A simulation script that mimics attacker behavior
- A custom Falco rule designed to catch that behavior
- A test runner script (`test-lab.sh`) to automate validation with pass/fail output

This enables:

- Reliable validation of detection logic
- Fast tuning during development
- Repeatable tests for confidence in production rules

---

## 📌 MITRE ATT&CK Mapping

Detection modules include mapped MITRE techniques to better contextualize threat coverage, such as:

- T1609 – Container Administration Command
- T1611 – Escape to Host
- T1546.001 – Event Triggered Execution
- T1203 – Exploitation for Client Execution

---

## ✅ Outcomes

- Proved that TOCTOU-style tampering is detectable by syscall monitoring
- Validated that detection triggers exactly during the exploitation window
- Demonstrated prevention with enforcement at the LSM layer
- Simulated and detected Kubernetes API misuse via over-permissioned RBAC
- Documented detection logic, simulation results, and impact for each scenario

---

## 🤖 Credits

Built using:
- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- Guided by AI assistant (ChatGPT 4.0) for structure, rules, and simulation logic