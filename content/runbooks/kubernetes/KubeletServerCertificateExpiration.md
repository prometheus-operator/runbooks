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

## Mitigation

Update certificates in the cluster control nodes and the worker nodes.
Refer to the documentation of the tool used to create cluster.

Another option is to delete node if it affects only one,

In extreme situations recreate cluster.
