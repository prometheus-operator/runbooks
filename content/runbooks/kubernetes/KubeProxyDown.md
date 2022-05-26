# KubeProxyDown

## Meaning

The `KubeProxyDown` alert is triggered when all Kubernetes Proxy instances have not
been reachable by the monitoring system for more than 15 minutes.

## Impact

This is a critical alert. The Kubernetes Proxy is not responding. The
cluster may partially or fully non-functional.

## Diagnosis

Check the status of the `kube-proxy` daemon sets in the `kube-system` namespace.

```console
kubectl get pods -l k8s-app=kube-proxy -n kube-system
```

Check the specific daemon-set for logs with the following command:

```console
kubectl logs -n kube-system kube-proxy-b9g23
```

## Mitigation

### AWS EKS
If you are running AWS EKS cluster and you find that the `kube-proxy` pods are all running normally, make sure to update the `kube-proxy-config` cm as shown below.

```console
kubectl edit cm -n kube-system kube-proxy-config
...
metricsBindAddress: 0.0.0.0:10249
...
```
This setting configures the IP address with port for the metrics server to serve on (set to '0.0.0.0:10249' for all IPv4 interfaces and '[::]:10249' for all IPv6 interfaces). More information on the [documentation page](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)

Then just go delete `kube-proxy` pods and new ones will be created automatically.

```console
kubectl delete pod -l k8s-app=kube-proxy -n kube-system
```
