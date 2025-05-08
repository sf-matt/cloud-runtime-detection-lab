# ☁️ cloud-runtime-detection-lab

A personal lab for developing, testing, and tuning cloud-native threat detections using open source tools like **Falco**, **KubeArmor**, and Kubernetes audit logs.

This project focuses on **real-world attacker techniques** in Kubernetes and cloud environments—especially those involving **TOCTOU abuse**, **syscall-based anomalies**, and **IAM privilege misuse**—and explores how to detect them with minimal noise and strong signal.

---

## 🧭 Goals

- Build a structured detection lab for runtime and cloud-native threat scenarios  
- Write and tune detection rules using Falco, KubeArmor, and SIGMA-like formats  
- Simulate realistic TTPs based on MITRE ATT&CK (Cloud + Container Matrix)  
- Explore automation for detection lifecycle: rule creation → testing → enrichment  
- Contribute usable detection artifacts to the security community  

---

## 🔍 Detection Focus Areas

### 1. **TOCTOU Attacks in Kubernetes**

- Attackers modify config/secrets between pod create and start  
- Risk: stealth privilege escalation or logic injection  
- Detection: file/secret changes + container lifecycle event correlation  

### 2. **Syscall-Level Anomaly Detection**

- Detect container escapes or host interaction via unexpected syscalls (e.g., `ptrace`, `chmod`, `mount`)  
- Tools: Falco + syscall profiling from normal pods  

### 3. **IAM Abuse and Privilege Escalation**

- ServiceAccount or workload misusing RBAC, cloud API tokens, or accessing unauthorized secrets  
- Detection: Audit logs + policy-based blocking via KubeArmor  

### 4. **Outbound Network Abuse**

- Pods making DNS tunneling attempts or curl/wget to unusual IPs  
- Detection: Falco netconnect rules + behavioral filtering  

---

## 🛠️ Lab Architecture

- **Kubernetes**: 2-node `kubeadm` cluster (control + worker)  
- **Runtime Tools**: [x] KubeArmor, [x] Falco (side-by-side), [ ] OpenTelemetry (planned)  
- **Logging**: Kubernetes audit logs, KubeArmor visibility, Falco syscalls  
- **Threat Simulation**: Custom scripts in `simulations/`, ATT&CK mapped  

---

## 📁 Project Structure

```bash
.
├── detections/
│   ├── TOCTOU-configmap.md
│   ├── syscall-anomaly-nginx.md
│   └── iam-misuse.md
├── rules/
│   ├── falco/
│   └── kubearmor/
├── simulations/
│   ├── simulate-toctou.sh
│   └── simulate-iam-abuse.yaml
├── lifecycle/
│   └── deploy-rule.sh
├── threat-models/
│   └── iam-lateral-movement.md
└── README.md
```

---

## 🧠 MITRE Coverage (Work in Progress)

Using [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) to track technique coverage for both:

- **Containers**: T1610, T1611, T1612, T1648  
- **Cloud (AWS/Azure)**: T1078.004, T1087, T1203  

---

## 📢 Updates & Learnings

_TBD — blog posts and detection write-ups coming soon._

---

## 🤝 Contributions & Collaboration

Open to:

- Detection rule contributions  
- Feedback on detection logic  
- Collaborators testing similar detection stacks  

---

### 🤖 Acknowledgments

Detection lab design and documentation assisted by [ChatGPT](https://openai.com/chatgpt) to accelerate content generation and rule scaffolding. All detection logic, tuning, and testing is performed manually in a personal Kubernetes lab.