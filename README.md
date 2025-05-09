# ☁️ Cloud Runtime Detection Lab

This repo demonstrates how to build, simulate, and document real-world Kubernetes runtime security detections using Falco and KubeArmor.

---

## 🎯 Purpose

- Write and test custom Falco detection rules
- Block known techniques with KubeArmor policies
- Simulate attacks like TOCTOU (Time-of-Check to Time-of-Use)
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
│   └── TOCTOU-outcome.md
├── lifecycle/
│   └── falco-rule-test.sh
├── rules/
│   ├── falco/
│   │   └── toctou-configmap-detect.yaml
│   └── kubearmor/
│       └── toctou-configmap-block.yaml
├── setup/
│   ├── falco-install.md
│   └── lab.md
├── simulations/
│   ├── simulate-toctou-block.sh
│   └── simulate-toctou-detect.sh
└── threat-models/                # (to be added)
```

---

## 🧪 Detection & Enforcement Scenarios

- **TOCTOU: ConfigMap Modification**
  - Falco detects unauthorized write attempts to `/mnt/configmap`
  - KubeArmor blocks those writes at runtime
  - Simulation script triggers the event for both tools
  - [View Detection Doc](detections/TOCTOU-configmap-detect.md)
  - [View Block Doc](detections/TOCTOU-configmap-block.md)

---

## ✅ Outcomes

- Proved that TOCTOU-style tampering is detectable by syscall monitoring
- Validated that detection triggers exactly during the exploitation window
- Demonstrated prevention with enforcement at the LSM layer
- Documented the full detection-prevention loop with MITRE context

---

## 📌 MITRE ATT&CK Mapping

Detection modules include mapped MITRE techniques to better contextualize threat coverage, such as:

- T1609 – Container Administration Command
- T1611 – Escape to Host
- T1546.001 – Event Triggered Execution
- T1203 – Exploitation for Client Execution

---

## 🤖 Credits

Built using:
- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- Guided by AI assistant (ChatGPT 4.0) for structure, rules, and simulation logic