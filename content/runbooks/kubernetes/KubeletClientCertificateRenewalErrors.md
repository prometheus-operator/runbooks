---
title: Kubelet Client Certificate Renewal Errors
weight: 20
---

# KubeletClientCertificateRenewalErrors

## Meaning

Kubelet on node  has failed to renew its client certificate
(XX errors in the last 15 minutes)

## Impact

Node will not be able to be used within the cluster.

## Diagnosis

Check when certificate was issued and when it expires.

## Mitigation

Update certificates in the cluster control nodes and the worker nodes.
Refer to the documentation of the tool used to create cluster.

Another option is to delete node if it affects only one,

In extreme situations recreate cluster.
