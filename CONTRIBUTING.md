# 🤝 Contributing Guide

Thanks for your interest in contributing to the Kubernetes Runtime Detection Lab!

We welcome well-scoped additions that align with our goals:
- Testing Kubernetes runtime detections using **Falco** or **KubeArmor**
- Demonstrating real-world attack patterns
- Supporting education and research in cloud-native security

---

## 🛠️ Add a New Detection

### 1. Scaffold it
Run the scaffold script:

```bash
./start-feature.sh
```

You’ll be prompted to enter:
- Tool (`falco` or `kubearmor`)
- Category (e.g. `rbac`, `toctou`, `creds`)
- Detection name (e.g. `block-service-token`)

This will:
- Create a feature branch
- Add:
  - `rules/<tool>/<category>/<name>.yaml`
  - `simulations/<tool>/<category>/simulate-<name>.sh`

### 2. Implement your detection and simulation
Make sure:
- Your rule is syntactically valid
- The simulation runs in a standard Kubernetes cluster
- Block or detect behavior is observable and verifiable

### 3. Register it
Add a new entry to:

```
detections/_registry.yaml
```

Include:
- `tool`
- `category`
- `rule` and `sim` paths
- `validate` keyword (if it should be checked by CI)
- (Optional) `mitre` technique mappings

### 4. Test it locally
Use the interactive lab runner:

```bash
./lifecycle/test-lab-v2.sh
```

Or run your simulation script directly.

---

## ✅ Validation & CI

All rules and simulations are automatically validated via GitHub Actions.

To validate locally:

```bash
./scripts/validate-falco-rules.sh
./scripts/validate-kubearmor-policies.sh
```

Please run these before submitting your pull request.

---

## 🚀 Submit Your Pull Request

Once your detection is ready:

1. Push your feature branch
2. Open a pull request against `main`
3. In your PR description, include:
   - What your rule detects
   - How the simulation demonstrates it
   - Any MITRE ATT&CK techniques it aligns with

---

Thanks again! 🔍  
Let’s build better detections — one controlled exploit at a time.