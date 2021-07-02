# KubeletTooManyPods

The Kubelet in a Kubernetes cluster is the agent that ensures Pods are running on that host.

Kubelet's have a configuration that limits how many Pods they can run. The default value of this is 110 Pods per Kubelet, but it is configurable (and this alert takes that configuration into account with the `kube_node_status_capacity_pods` metric). The alert fires when a Kubelet reaches 95% of its capacity. This alert warns about the likelihood that the cluster is close to running out of capacity to run Pods on the cluster. Either the cluster must be increased in its node count, or the number of Pods must be reduced.
