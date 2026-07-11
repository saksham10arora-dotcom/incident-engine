# Runbook: SSL/TLS Certificate Expired

## Problem Description
Client requests to web services fail during the SSL/TLS handshake because the server's certificate has expired. This prevents secure HTTPS communication.

## Diagnosis
- Analyze client-side error logs: `SSL_do_handshake() failed` or `sslv3 alert certificate expired`.
- Inspect certificate details via curl: `curl -vI https://your-service.domain.com` and check `expire date`.

## Remediation
- Renew the certificate with the Certificate Authority (e.g. Let's Encrypt, DigiCert).
- Update the gateway/web-server configuration (Nginx, Azure Gateway, Kubernetes Ingress Secret) with the new certificate and private key.
- Automate renewals using tools like Cert-manager or Azure Managed Certificates.
