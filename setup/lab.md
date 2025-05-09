# 🔧 Kubernetes Detection Lab Setup

This guide documents the environment used to build and test runtime detection scenarios like TOCTOU in the `cloud-runtime-detection-lab`.

---

## 🧱 Environment Details

- **Kubernetes version:** v1.31
- **OS:** Ubuntu 24.04 LTS
- **Cluster Type:** kubeadm (2-node)

---

## 🔐 Installed Security Tools

### Falco (Syscall Detection)

Installed via Helm:

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco -n falco --create-namespace
```

See [`setup/falco-install.md`](falco-install.md) for full configuration and custom rule deployment instructions.

---

### KubeArmor (Syscall Enforcement)

Installed from YAML template:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubearmor/KubeArmor/main/deployments/k8s-templates/kubearmor.yaml
```

To uninstall:
```bash
kubectl delete -f https://raw.githubusercontent.com/kubearmor/KubeArmor/main/deployments/k8s-templates/kubearmor.yaml
```

Full policy examples and tuning coming soon.