# Runbook: AWS IAM Permission Failure (AccessDenied)

## Problem Description
An application or user receives an `AccessDenied` error from AWS API calls. This is due to missing or incorrect policies attached to the IAM user or execution role assumed by the application.

## Diagnosis
- Inspect logs for errors containing `AccessDenied` and the requesting identity (e.g. AssumedRole).
- Find the API action and target resource in the error message (e.g. action `s3:PutObject` on resource `arn:aws:s3:::bucket-name/*`).

## Remediation
- Locate the IAM role (e.g., `AppExecutionRole`) in the AWS console or IaC codebase.
- Add an IAM policy statement allowing the specified action on the resource:
```json
{
  "Effect": "Allow",
  "Action": [
    "s3:PutObject"
  ],
  "Resource": "arn:aws:s3:::company-payments-prod/*"
}
```
- Redeploy/apply the updated configuration using Terraform or AWS CLI.
