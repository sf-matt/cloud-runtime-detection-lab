[![Build Status](https://img.shields.io/badge/lab--status-active-brightgreen)](https://github.com/sf-matt/cloud-runtime-detection-lab)

# 🛡️ Cloud Runtime Detection Lab

A hands-on, rule-driven lab for testing and validating Kubernetes runtime threat detections using tools like **Falco** and **KubeArmor**.

---

## 🚀 Quickstart

```bash
git clone https://github.com/sf-matt/cloud-runtime-detection-lab.git
cd cloud-runtime-detection-lab
./bootstrap.sh
./test-lab-v2.sh
```

---

## 📦 Requirements

- ✅ Kubernetes cluster (minikube, kind, or real)
- ✅ `kubectl` + `helm`
- ✅ [`yq` (Mike Farah version)](https://github.com/mikefarah/yq)
- ✅ [`bash` with arrays and `mapfile` support]

---

## 🧰 Tool Installation

### 🐺 Install Falco

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm install falco falcosecurity/falco -n falco --create-namespace
```

### 🛡️ Install KubeArmor

```bash
helm repo add kubearmor https://kubearmor.github.io/charts
helm repo update kubearmor
helm upgrade --install kubearmor-operator kubearmor/kubearmor-operator -n kubearmor --create-namespace
kubectl apply -f https://raw.githubusercontent.com/kubearmor/KubeArmor/main/pkg/KubeArmorOperator/config/samples/sample-config.yml
```

---

## 🧪 Running Tests

### Interactive menu:
```bash
./test-lab-v2.sh
```

### Auto-run all:
```bash
./test-lab-v2.sh --auto
```

### Filter by category:
```bash
./test-lab-v2.sh --category=rbac
```

---

## 🗃️ Detection Registry

All detection metadata lives in:

📄 [`detections/_registry.yaml`](./detections/_registry.yaml)

Includes:
- Tool (Falco/KubeArmor)
- Rule + simulation path
- Validation keyword
- MITRE mapping
- Category

Used to dynamically drive the lab menu and auto-validate detections.

---

## 📊 Detection Summary

**Total Detections:** X  
- 🐺 Falco: X  
- 🛡️ KubeArmor: X

_(Run `yq e '.[].tool' detections/_registry.yaml | sort | uniq -c` to update counts)_

---

## ✅ CI & Validation

### Included:
- `validate-registry.sh`: checks for required registry fields and existing sim paths
- `rule-check.sh`: confirms rule YAML files exist and sim scripts are executable

CI runs automatically on pull requests to `main`.

---

## 🗃️ Repo Structure

```
rules/              # Falco & KubeArmor detection rules
simulations/        # Scripts to simulate attacks
lifecycle/          # Helpers like log validators and rule deploy
detections/
  _registry.yaml    # Canonical detection list
test-lab-v2.sh      # Dynamic interactive test runner
bootstrap.sh        # Permissions + Falco rule deploy
validate-registry.sh
rule-check.sh
```

---

## 🤝 Contributing

We welcome PRs! Please:

- Add any new detection rule to `rules/` and its matching sim to `simulations/`
- Register your detection in `detections/_registry.yaml`
- Follow the naming structure by tool/category/rule
- Run `./bootstrap.sh` before testing
- Test your detection using `test-lab-v2.sh`

---

## 💬 License & Attribution

MIT License. This project draws from real-world techniques, open source tooling, and ongoing security research into Kubernetes runtime threats.

- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- [ChatGPT](https://openai.com/chatgpt) — used to speed up testing, writing, and iteration
