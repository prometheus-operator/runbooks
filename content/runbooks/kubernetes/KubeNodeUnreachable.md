---
title: Kube Node Unreachable
weight: 20
---

# KubeNodeUnreachable

## Meaning

Kubernetes node is unreachable and some workloads may be rescheduled.

## Impact

The performance of the cluster deployments is affected, depending on the overall
workload and the type of the node.

## Diagnosis

The notification details should list the node that's not reachable. For Example:

```txt
 - alertname = KubeNodeUnreachable
...
 - node = node1.example.com
...
```

Login to the cluster. Check the status of that node:

```shell
$ kubectl get node $NODE -o yaml
```

The output should describe why the node is not reachable.

Common failure scenarios:

- disruptive software upgrades
- network patitioning due to hardware failures
- firewall rules
- virtual machines suspended due to storage area network problems
- system crashes / freezes due to software or hardware malfunctions

## Mitigation

In case of maintenance ensure to [cordon and drain node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/).

In other cases ensure storage and networking redundancy if applicable.

See [KubeNode](https://kubernetes.io/docs/concepts/architecture/nodes/#condition)
See [node problem detector](https://github.com/kubernetes/node-problem-detector)
See [Watchdog timer](https://en.wikipedia.org/wiki/Watchdog_timer)
