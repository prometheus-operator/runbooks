---
title: Kubelet Down
weight: 20
---

# KubeletDown

## Meaning

This alert is triggered when the monitoring system has not been able to reach
any of the cluster's Kubelets for more than 15 minutes.

## Impact

This alert represents a critical threat to the cluster's stability. Excluding
the possibility of a network issue preventing the monitoring system from
scraping Kubelet metrics, multiple nodes in the cluster are likely unable to
respond to configuration changes for pods and other resources, and some
debugging tools are likely not functional, e.g. `kubectl exec` and `kubectl logs`.

## Diagnosis

Check the status of nodes and for recent events on `Node` objects, or for recent
events in general:

```console
$ kubectl get nodes
$ kubectl describe node $NODE_NAME
$ kubectl get events --field-selector 'involvedObject.kind=Node'
$ kubectl get events
```

If you have SSH access to the nodes, access the logs for the Kubelet directly:

```console
$ journalctl -b -f -u kubelet.service
```

## Mitigation

The mitigation depends on what is causing the Kubelets to become
unresponsive. Check for wide-spread networking issues, or node level
configuration issues.

See [Kubernetes Docs - kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
