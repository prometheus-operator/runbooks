---
title: Kube Node Not Ready
weight: 20
---

# KubeNodeNotReady

## Meaning

KubeNodeNotReady alert is fired when a Kubernetes node is not in `Ready`
state for a certain period. In this case, the node is not able to host any new
pods as described [here](https://kubernetes.io/docs/concepts/architecture/nodes/#condition).

## Impact

The performance of the cluster deployments is affected, depending on the overall
workload and the type of the node.

## Diagnosis

The notification details should list the node that's not ready. For Example:

```txt
 - alertname = KubeNodeNotReady
...
 - node = node1.example.com
...
```

Login to the cluster. Check the status of that node:

```shell
$ kubectl get node $NODE -o yaml
```

The output should describe why the node isn't ready (e.g.: timeouts reaching the
API or kubelet).

## Mitigation

Once, the problem was resolved that prevented node from being replaced,
the instance should be terminated.

* See [KubeNode](https://kubernetes.io/docs/concepts/architecture/nodes/#condition)
* See [node problem detector](https://github.com/kubernetes/node-problem-detector)
