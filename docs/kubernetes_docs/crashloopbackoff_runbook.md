# Runbook: Kubernetes CrashLoopBackOff

## Problem Description
A container starts, fails, and restarts repeatedly. Kubernetes increases the delay between restarts (backoff delay). This is usually caused by application errors during startup, such as missing configuration, environment variables, database connection issues, or wrong command arguments.

## Diagnosis
- Check pod status: `kubectl get pods` shows `CrashLoopBackOff`.
- Fetch container logs: `kubectl logs <pod-name> --previous` to see why the application exited.

## Remediation
- Check application logs to identify the missing dependency (e.g. Redis, DB).
- Ensure configuration parameters and environment variables are correctly mapped in the deployment spec.
- Check service connectivity or dependencies, e.g. configure redis endpoint correctly in the deployment's env config.
