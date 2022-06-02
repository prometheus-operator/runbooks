# KubeMemoryOvercommit

## Meaning

This alert fires if the cluster does not have enough total memory to tolerate failure of the largest node in the cluster.

<details>
<summary>Full context</summary>

Each pod requests a certain amount of memory in the pod spec field `resource.requests.memory`.  This value can also be
found via the metric `kube_pod_container_resource_requests{resource="memory"}`.  If a node failure occurs, it's possible that
some pods will not be rescheduled due to a lack of resources.  Thus it's recommended that the cluster has enough total resources
to tolerate a failure of the largest node, at least until that node is replaced.

This alert is calculated by comparing the total memory requested by the pods to the total memory available in the cluster minus the
amount of memory on the largest node.

</details>

## Impact

There is no immediate impact of this alert, however, if a node failure occurs, cluster availability will likely be affected.

## Diagnosis

Check the number and types of nodes being used in the cluster to decide if an additional node is needed.  This could also be caused by an imbalance of node groups.  For example, if there is a single large node running an app with a large memory requirement, it may not be schedulable
if that one large node fails.

## Mitigation

Adding an additional node (of the largest type in the cluster) or reducing the pod memory requests will normally resolve this issue.
Alternatively, if there are multiple node groups of different types, it may be possible to re-balance the cluster by adding a large
node and removing some small nodes.
