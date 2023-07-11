# Kubernetes API Server Latency

## Severity Level

**Warning**

## Impact

High API server latency can have various negative impacts, including slow response times for users and services, potential timeouts, and overall poor cluster performance.

## Description

The alert `KubernetesApiServerLatency` fires when the 99th percentile latency of the Kubernetes API server, for requests not being 'CONNECT', 'WATCHLIST', 'WATCH', or 'PROXY' and with a subresource that is not 'log', exceeds 1 second over a period of 2 minutes.

The histogram is calculated over a 10-minute period. The metric is measured in seconds and the alarm is set to trigger when the latency crosses the threshold of 1 second.

The alarm does not take into account the 'instance' and 'resource' labels of the metric.

## Debugging Steps

1. First, it's essential to verify the alert and check the current status of API server latency. You can use the Prometheus query given in the alert or use the following command:

    ```sh
    histogram_quantile(0.99, sum(rate(apiserver_request_latencies_bucket{subresource!="log",verb!~"^(?:CONNECT|WATCHLIST|WATCH|PROXY)$"} [10m])) WITHOUT (instance, resource)) / 1e+06
    ```

2. Check if there's any sudden increase in the number of requests to the Kubernetes API server. If there's a sudden burst of requests, that might cause an increase in API server latency.

3. Check the logs of the Kubernetes API server for any unusual or error messages.

4. Look into resource usage and performance of the Kubernetes API server. Check for high CPU usage, memory leaks or disk I/O issues.

5. Look for any networking issues that might be causing high latency. This could include packet loss, high network latency, or problems with network hardware.

## Prevention

- Monitor the load on your Kubernetes API server and scale it up if needed. This could be done either horizontally (by increasing the number of replicas) or vertically (by increasing the resources allocated to the Kubernetes API server).

- Enable rate limiting to prevent any sudden burst of requests to the Kubernetes API server.

- Regularly check for any performance or resource usage issues and take necessary action before it leads to high latency.

- Regularly review your network performance and take necessary steps to improve it if required.
