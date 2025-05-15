# ☁️ Kubernetes Runtime Detection Lab

![Validate Detection Registry](https://github.com/sf-matt/cloud-runtime-detection-lab/actions/workflows/validate.yml/badge.svg)

This repository is a lab-driven framework for building and testing Kubernetes runtime security detections using tools like **Falco** and **KubeArmor**.

---

## 🚀 Getting Started

### ✅ Prerequisites
- Kubernetes cluster (local or remote)
- `kubectl` access
- Helm installed
- (Optional) Audit logging enabled for RBAC detection

### 🧰 Bootstrap the Environment
```bash
./lifecycle/bootstrap.sh
```
This will:
- Make scripts executable
- Deploy custom Falco rules
- Set up your working environment

---

## 🧪 Running the Lab

Use the interactive runner:

```bash
./lifecycle/test-lab-v2.sh
```

You can:
- Trigger specific detection tests
- Reapply rules or policies
- View filtered logs

---

## 🛠️ Detection Rule Scaffolding: `start-feature.sh`

Helper script to scaffold a new detection.

```bash
./start-feature.sh
```

It will:
- Prompt for tool, category, and detection name
- Create a new Git branch
- Scaffold matching rule and sim files
- Print output locations

See [`scaffold-instructions.md`](./scaffold-instructions.md) for details.

---

## 📁 Repository Structure

```
.
├── detections/
│   └── _registry.yaml              # Master detection index
├── lifecycle/
│   ├── bootstrap.sh                # Makes scripts ready, applies rules
│   ├── deploy-falco-rules.sh       # Merges and applies rules
│   └── test-lab-v2.sh              # Interactive detection runner
├── rules/
│   ├── falco/
│   └── kubearmor/
├── simulations/
│   ├── falco/
│   └── kubearmor/
├── scripts/
│   ├── validate-falco-rules.sh     # Rule syntax check for CI
│   └── validate-kubearmor-policies.sh
├── start-feature.sh                # Scaffold script
└── README.md
```

---

## ✅ GitHub Actions & CI

Validation scripts for contributed rules live in `scripts/`. These are used by our CI to ensure contributed policies or rules pass basic syntax checks.

---

## 🤝 Contributing

New detection ideas or rule improvements? See [CONTRIBUTING.md](./CONTRIBUTING.md) to get started.

---

## 💬 License & Attribution

MIT License. Inspired by real-world attacks, open-source rulesets, and community contributions to Kubernetes runtime security.

- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- [ChatGPT](https://openai.com/chatgpt) for assistance and scaffolding