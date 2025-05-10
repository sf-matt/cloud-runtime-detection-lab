# ☁️ Cloud Runtime Detection Lab

This repo demonstrates how to build, simulate, and validate real-world Kubernetes runtime security detections using Falco and KubeArmor.

---

## 🎯 Purpose

- Build custom runtime detections and prevention rules
- Simulate attacks to validate detections (TOCTOU, RBAC misuse, etc.)
- Use Falco for detection and KubeArmor for enforcement
- Validate detections with structured, test-driven workflows
- Run tool-isolated tests from a clean CLI menu

---

## 📁 Folder Structure (Alphabetical)

```bash
.
├── detections/                  # 📄 Per-scenario documentation
│   ├── debug.md
│   ├── detection.md             # ✅ Detection summary
│   ├── rbac.md
│   └── toctou.md
├── lifecycle/                   # ⚙️ Deployment & test scripts
│   ├── deploy-falco-rules.sh
│   └── test-lab.sh
├── rules/                       # 🛡️ Detection policies
│   ├── falco/
│   │   ├── debug/
│   │   │   └── test-write-syscall.yaml
│   │   ├── rbac/
│   │   │   └── rbac-api-misuse-audit.yaml
│   │   └── toctou/
│   │       └── toctou-configmap-detect.yaml
│   └── kubearmor/
│       └── toctou/
│           └── toctou-configmap-block.yaml
├── simulations/                 # 🔬 Attack simulations
│   ├── falco/
│   │   ├── debug/
│   │   │   └── simulate-generic-write.sh
│   │   ├── rbac/
│   │   │   ├── rbac-abuser-role.yaml
│   │   │   └── simulate-rbac-abuse.sh
│   │   └── toctou/
│   │       └── simulate-detect.sh
│   └── kubearmor/
│       └── toctou/
│           └── simulate-block.sh
└── README.md                    # 📘 Main lab instructions
```

---

## 🛠 Helm Install for Full Lab Support

This command enables:
- Syscall-based detections (eBPF + `-A` for full syscall coverage)
- Audit log ingestion for Kubernetes API detections

```bash
helm upgrade --install falco falcosecurity/falco -n falco --create-namespace \
  --set ebpf.enabled=true \
  --set falco.jsonOutput=true \
  --set falco.textOutput=true \
  --set falco.args="-A" \
  --set auditLog.enabled=true \
  --set auditLog.dynamicBackend.enabled=true \
  --set auditLog.dynamicBackend.config.apiVersion=v1 \
  --set auditLog.dynamicBackend.config.kind=ConfigMap \
  --set auditLog.dynamicBackend.config.name=auditlog-config \
  --set auditLog.dynamicBackend.config.namespace=falco
```

---

## 🧪 Run the Test Lab

```bash
./lifecycle/test-lab.sh --reload
```

Includes:
- Falco TOCTOU Detection (Syscall)
- Falco RBAC API Abuse Detection (Audit)
- Falco Debug Rule Validation
- KubeArmor ConfigMap Enforcement (TOCTOU)
- Built-in cleanup + log viewer

---

## 🧩 MITRE Techniques Mapped

| Scenario               | Tool    | Source     | MITRE Tactics        | Status      |
|------------------------|---------|------------|-----------------------|-------------|
| TOCTOU ConfigMap Write | Falco   | Syscall    | T1611, T1203          | ✅ Working  |
| RBAC API Misuse        | Falco   | k8s_audit  | T1078.004, T1087      | ✅ Working  |
| Generic Write Debug    | Falco   | Syscall    | Diagnostic only       | ✅ Working  |

---

## 🤖 Credits

- [Falco](https://falco.org/)
- [KubeArmor](https://github.com/kubearmor/KubeArmor)
- [ChatGPT](https://openai.com/chatgpt) for pairing on rule tuning and detection validation