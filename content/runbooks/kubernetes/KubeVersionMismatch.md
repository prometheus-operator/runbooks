---
title: Kube Version Mismatch
weight: 20
---

# KubeVersionMismatch

## Meaning

Different semantic versions of Kubernetes components running.
Usually happens during kubernetes cluster upgrade process.

<details>
<summary>Full context</summary>

Kubernetes control plane nodes or worker nodes use different versions.
This usually happens when kubernetes cluster is upgraded between minor and
major version.

</details>

## Impact

Incompatible API versions between kubernetes components may have very
broad range of issues, influencing single containers, through app stability,
ending at whole cluster stability.

## Diagnosis

- Check existing kubernetes versions via `kubectl get nodes` and see
  VERSION column
- Check if there is ongoing kubernetes upgrade - especially in managed services
  in the cloud

## Mitigation

- Drain affected nodes, then upgrade or replace them with newer ones,
  see [Safely drain node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)

- Ensure to set proper control plane version and node pool versions when
  creating clusters.
- Ensure auto cluster updates for control plane and node pools.
- Set proper maintenance windows for the clusters.
