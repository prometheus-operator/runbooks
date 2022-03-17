---
title: Kube Quota Exceeded
weight: 20
---

# KubeQuotaExceeded

## Meaning

Cluster reaches to the allowed hard limits for given namespace.

## Impact

Inability to create resources in kubernetes.

## Diagnosis

- Check resource usage for the namespace in given time span

## Mitigation

- Review existing quota for given namespace and adjust it accordingly.
- Review resources used by the quota and fine tune them.
- Continue with standard capacity planning procedures.
- See [Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
