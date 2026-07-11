# Runbook: Kubernetes OOMKilled (Exit Code 137)

## Problem Description
A container is terminated with exit code 137 and reason `OOMKilled`. This occurs when the container's memory consumption exceeds the limit specified in its pod spec. The Linux kernel's Out-Of-Memory (OOM) killer kills the process to protect the node's stability.

## Diagnosis
- Check pod status: `kubectl get pods` showing OOMKilled.
- Check logs and describe pod: `kubectl describe pod <pod-name>` shows `Last State: Terminated`, `Reason: OOMKilled`, `Exit Code: 137`.

## Remediation
Increase the memory limit in the deployment manifest or statefulset spec:
```yaml
resources:
  limits:
    memory: "1Gi" # Increase this value (e.g. from 512Mi to 1Gi)
  requests:
    memory: "512Mi"
```
