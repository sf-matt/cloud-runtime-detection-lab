# ☁️ Cloud Runtime Detection Lab

This repo demonstrates how to build, simulate, and document real-world Kubernetes runtime security detections using Falco and KubeArmor.

---

## 🎯 Purpose

- Build custom runtime detections and prevention rules
- Simulate attacks to validate detections (TOCTOU, RBAC misuse)
- Use Falco for detection and KubeArmor for enforcement
- Validate detections with structured, test-driven workflows
- Operate modular, tool-separated tests with simple CLI menus

---

## 📁 Structure Overview

```bash
.
├── detections/                  # Markdown docs explaining each scenario
├── lifecycle/                   # Scripts to deploy rules and run tests
│   ├── deploy-falco-rules.sh    # Modular deploy: pass "toctou", "rbac", or "all"
│   └── test-lab.sh              # Interactive detection and policy tester
├── rules/
│   ├── falco/
│   │   ├── toctou/
│   │   │   └── toctou-configmap-detect.yaml
│   │   └── rbac/
│   │       └── rbac-api-misuse-detect.yaml
│   └── kubearmor/
│       └── toctou-configmap-block.yaml
├── simulations/
│   ├── simulate-toctou-detect.sh
│   ├── simulate-toctou-block.sh
│   └── simulate-rbac-abuse.sh
├── rbac-abuser-role.yaml        # RBAC setup for the misuse test
└── README.md
```

---

## 🧪 Test-Driven Detection Development (TDDD)

Each scenario includes:

- A simulation script to reproduce attacker behavior
- A custom detection rule (Falco or KubeArmor)
- A test menu entry that deploys rules, runs simulations, and checks logs
- ✅ / ❌ feedback so you know if the detection fired

---

## 🧭 How to Use

### 🛠 Deploy Falco Rules

```bash
./lifecycle/deploy-falco-rules.sh toctou
./lifecycle/deploy-falco-rules.sh rbac
./lifecycle/deploy-falco-rules.sh all
```

---

### 🔬 Run Tests

```bash
./lifecycle/test-lab.sh
```

Menu gives you:
- Falco detections (TOCTOU, RBAC)
- KubeArmor enforcement
- Log viewing (per tool)

---

## 🔍 Scenarios Included

| Scenario               | Detection Tool | Prevention Tool | MITRE Techniques |
|------------------------|----------------|------------------|------------------|
| TOCTOU ConfigMap Write | Falco          | KubeArmor        | T1611, T1203     |
| RBAC API Misuse        | Falco          | N/A              | T1078.004, T1087 |

---

## 🤖 Credits

Built with:
- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- [ChatGPT](https://openai.com/chatgpt) for rule design, scripting, and simulation logic