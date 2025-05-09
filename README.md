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
│   ├── simulate-toctou-block.yaml
│   └── simulate-toctou-detect.sh
└── threat-models/                # (to be added)
```

> 💡 Each detection module includes: a rule, a simulation, and supporting documentation. Prevention rules (KubeArmor) are paired with detection logic (Falco) to show defense-in-depth.

---

## 🚀 Getting Started with Falco

Install Falco with Helm:

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm install falco falcosecurity/falco -n falco --create-namespace
```

For full instructions and how to add custom rules, see: [`setup/falco-install.md`](setup/falco-install.md)

---

## 🧪 Detection Scenarios

- **TOCTOU: ConfigMap Modification**
  - Falco detects unauthorized write attempts to `/mnt/configmap`
  - KubeArmor prevents those writes with a block policy
  - Simulation script triggers the event for both tools

---

## ✅ Outcomes

- Proved that TOCTOU-style tampering is detectable by syscall monitoring
- Validated that detection triggers exactly during the exploitation window
- Documented with full rule logic, simulation artifacts, and alert analysis
- Next: Add more detection bundles for DNS tunneling, IAM abuse, etc.

---

## 🤖 Credits

Built using:
- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- Guided by AI assistant (ChatGPT 4.0) for structure, rules, and simulation logic