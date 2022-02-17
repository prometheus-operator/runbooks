---
title: Kube Quota Almost Full
weight: 20
---

# KubeQuotaAlmostFull

## Meaning

Cluster reaches to the allowed limits for given namespace.

## Impact

In the future deployments may not be possbile.

## Diagnosis

- Check resource usage for the namespace in given time span

## Mitigation

- Review existing quota for given namespace and adjust it accordingly.
- Review resources used by the quota and fine tune them.
- Continue with standard capacity planning procedures.
- See [Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)

