# 🧪 Debug Rule: Generic Write Syscall Detection

## 🧠 Scenario

This rule is designed for validating that Falco's syscall engine is functioning correctly. It fires on any `write` syscall made inside a container. It is intentionally broad and should only be used for test environments.

## 🛠 Tool: Falco

- **Source:** Syscall
- **Detection Method:** Matches `evt.type = write` from any container
- **Rule File:** `rules/falco/debug/test-write-syscall.yaml`

### Falco Rule Highlights
```yaml
evt.type = write and container
```

## 🧪 Simulation

**Script:** `./simulations/falco/debug/simulate-generic-write.sh`  
**Action:** Writes to `/tmp/debug.txt` using `echo hello > /tmp/debug.txt`

Expected log output:
```
TEST: Write syscall detected by sh on file /tmp/debug.txt
```

## ✅ Validation

- Confirms that Falco's eBPF probe is active
- Proves that rules using syscall-based detections will work

## 🧩 MITRE ATT&CK Mapping

*This is a diagnostic rule and not mapped to an attack technique.*