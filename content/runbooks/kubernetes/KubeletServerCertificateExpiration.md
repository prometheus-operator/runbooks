---
title: Kubelet Server Certificate Expiration
weight: 20
---

# KubeletServerCertificateExpiration

## Meaning

Server certificate for Kubelet on node expires soon or already expired.

## Impact

**Critical** - Cluster will be in inoperable state.

## Diagnosis

Check when certificate was issued and when it expires.

Check the pending csr with `kubectl get csr`

## Mitigation
If there's any csr regarding to the node, verify the csr manually, approve the csr with command `kubectl certificate approve <csr-id>`

Please notice that server certificate is not automatically approved for security reason, see [document](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/#certificate-rotation) for detail.
