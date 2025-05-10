# 🧠 Contributing to cloud-runtime-detection-lab

This lab explores and validates Kubernetes runtime security detections using both **Falco** and **KubeArmor**.

Whether you're adding new detections, refining simulations, or experimenting with tooling, this doc outlines how to structure your work and what “done” looks like.

---

## 📂 Folder Structure

- `detections/` — Markdown files for each scenario (TOCTOU, RBAC, debug, etc.)
- `lifecycle/` — Core scripts like test-lab and rule deployment
- `rules/` — Organized by tool (`falco/`, `kubearmor/`) and use case
- `simulations/` — Mirrors `rules/` and holds all test scripts
- `README.md` — Project overview and usage instructions

---

## 🌱 Branching Model

This repo uses Git branches to separate stable work from active development.

| Branch       | Purpose                                        |
|--------------|------------------------------------------------|
| `main`       | Verified detections, polished documentation    |
| `feature/*`  | In-progress rules, simulations, or integrations|

You can use branches like `feature/kubearmor-toctou`, `feature/falco-network-dns`, etc.  
Once validated, merge into `main`.

---

## ✅ What Counts as Complete

A detection is considered complete when it meets the following:

- [ ] A YAML rule exists in `rules/<tool>/<use-case>/`
- [ ] A simulation script exists in `simulations/<tool>/<use-case>/`
- [ ] Logs confirm detection (via `test-lab.sh`)
- [ ] Detection is documented in `detections/<use-case>.md`
- [ ] Rule maps to at least one MITRE ATT&CK technique (where applicable)

---

## 🧪 Testing Your Work

```bash
# Deploy updated rules
./lifecycle/deploy-falco-rules.sh all

# Run a simulation
./lifecycle/test-lab.sh --reload

# View logs
kubectl logs -n falco -l app.kubernetes.io/instance=falco --tail=300
```

For KubeArmor, use:

```bash
kubectl logs -n kubearmor -l kubearmor-app=kubearmor --tail=300
```

---

## 💬 Notes

- Debug rules and general test scripts should live in `debug/` folders
- Keep simulations self-cleaning where possible
- Keep rule conditions minimal but meaningful

Thanks for contributing to runtime security learning!