# Runbook: Docker Image Pull Failures & ImagePullBackOff

## Problem Description
Docker/Kubernetes cannot pull the requested container image from the container registry. This can occur due to:
- Incorrect image tag or name.
- Invalid registry credentials or lack of authorization.
- Registry rate-limiting or downtime.

## Diagnosis
- Run `docker pull <image_name>` or check Kubernetes status `kubectl describe pod <pod-name>` which shows `ImagePullBackOff` or `ErrImagePull`.
- Look for registry error messages in `dockerd` logs.

## Remediation
- Verify image name and tag exist in the registry.
- Ensure correct credentials are provided via `docker login` or Kubernetes `imagePullSecrets`.
- Update credentials in deployment configs if they have expired.
