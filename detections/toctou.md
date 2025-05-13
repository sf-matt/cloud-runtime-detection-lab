# TOCTOU Detection and Prevention

This detection scenario demonstrates rule-level simulation of TOCTOU-style behavior in Kubernetes environments. While these examples do not represent full real-world exploitation techniques, they model important system behaviors that security policies should monitor or block.

⚠️ **Note:** These tests simulate policy effectiveness. Real-world TOCTOU threats often involve API-based privilege escalation, config replacement, or race conditions in CI/CD and deployment pipelines.

---

## Falco (Detection)

This rule detects write syscalls to config-like mount paths (e.g. `/mnt/configmap`) by known tools (e.g. `echo`, `cp`, `sed`, etc). It is triggered when a writable syscall is executed in a container, simulating TOCTOU-like behavior.

### Rule location:
```
rules/falco/toctou-configmap-write.yaml
```

### Simulation path:
```
simulations/falco/toctou/simulate-detect.sh
```

### Validation
You can confirm detection using:

```
./lifecycle/check-falco-logs.sh TOCTOU
```

Or manually check logs:

```
kubectl logs -n falco -l app.kubernetes.io/instance=falco -c falco --tail=100
```

### Example Output:
```
TOCTOU ConfigMap modification attempt detected by sh (user=root, container=abc123)
opening file /mnt/configmap/entry
```

---

## KubeArmor (Prevention)

This policy blocks actual file write attempts to `/mnt/configmap/`, which is configured as a writable `emptyDir` mount in the test pod. The simulation confirms that KubeArmor enforces prevention at runtime.

### Policy location:
```
rules/kubearmor/toctou/toctou-configmap-block.yaml
```

### Simulation path:
```
simulations/kubearmor/toctou/simulate-block.sh
```

### Validation
To confirm enforcement, check KubeArmor logs:

```
kubectl logs -n kubearmor -l kubearmor-app=kubearmor --tail=100
```

Look for messages showing blocked write attempts or enforcement activity tied to the pod.

### Expected Result:
Attempted writes (e.g. `echo blocked > /mnt/configmap/test`) fail with:
```
sh: can't create /mnt/configmap/test: Permission denied
```

This demonstrates successful runtime enforcement of write protection to configuration-like paths.