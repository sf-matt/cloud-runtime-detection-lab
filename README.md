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

## 🧱 Repo Structure (Simplified)

```
rules/              # Falco & KubeArmor detection rules
simulations/        # Scripts to simulate attacks
lifecycle/          # Helpers like log validators and rule deploy
detections/
  _registry.yaml    # Canonical detection list
test-lab-v2.sh      # Dynamic interactive test runner
bootstrap.sh        # Permissions + Falco rule deploy
```

---

## 🧩 Gotchas

| ⚠️ Issue | ✅ Fix |
|---------|--------|
| `yq: Unknown option -o=json` | You're using the wrong yq — install [this one](https://github.com/mikefarah/yq) |
| `permission denied` on scripts | Run `./bootstrap.sh` to fix permissions |
| RBAC sim fails | That’s expected — detection triggers on denial |
| No detections show up | Make sure Falco is running and has audit logging |
| KubeArmor doesn't block | Make sure you're running on AppArmor-compatible host (Ubuntu, etc.) |

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

MIT License. Inspired by real-world attacks, open-source rulesets, and community discussions around Kubernetes runtime security.

- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- [ChatGPT](https://openai.com/chatgpt) for so much