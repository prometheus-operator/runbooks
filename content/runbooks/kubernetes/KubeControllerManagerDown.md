---
title: Kube Controller Manager Down
weight: 20
---

# KubeControllerManagerDown

## Meaning

KubeControllerManager has disappeared from Prometheus target discovery.

## Impact

The cluster is not functional and Kubernetes resources cannot be reconciled.

<details>
<summary>Full context</summary>

More about kube-controller-manager function can be found at https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/

</details>

## Diagnosis

TODO

## Mitigation

See old CoreOS docs in [Web Archive](http://web.archive.org/web/20201026205154/https://coreos.com/tectonic/docs/latest/troubleshooting/controller-recovery.html)
