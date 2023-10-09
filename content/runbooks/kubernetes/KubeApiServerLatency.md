---
title: KubernetesApiServerLatency
menu: main
weight: -100
---

# KubernetesApiServerLatency

## Meaning

The alert `KubernetesApiServerLatency` fires when the 99th percentile latency of the Kubernetes API server, for requests not being 'CONNECT', 'WATCHLIST', 'WATCH', or 'PROXY' and with a subresource that is not 'log', exceeds 1 second over a period of 2 minutes. The histogram is calculated over a 10-minute period. 

<details>
<summary>Full context</summary>

This alert is part of the Kubernetes metrics collected by Prometheus. It helps to ensure the responsiveness of the Kubernetes API server. The alert takes into account all the requests except those labeled 'CONNECT', 'WATCHLIST', 'WATCH', or 'PROXY', and with a subresource that is not 'log'. The histogram is calculated by aggregating data over a 10-minute period. The metric is measured in seconds and the alarm is set to trigger when the latency crosses the threshold of 1 second over a 2 minutes period. This alert serves as an early warning sign for high latency that could potentially lead to poor cluster performance or even timeouts.

</details>

## Impact

High API server latency can have various negative impacts, including slow response times for users and services, potential timeouts, and overall poor cluster performance.

## Diagnosis

- Verify the alert and check the current status of API server latency using the Prometheus query given in the alert.

    ```sh
    histogram_quantile(0.99, sum(rate(apiserver_request_latencies_bucket{subresource!="log",verb!~"^(?:CONNECT|WATCHLIST|WATCH|PROXY)$"} [10m])) WITHOUT (instance, resource)) / 1e+06
    ```

- Check if there's any sudden increase in the number of requests to the Kubernetes API server. If there's a sudden burst of requests, that might cause an increase in API server latency.

- Check the logs of the Kubernetes API server for any unusual or error messages.

- Look into resource usage and performance of the Kubernetes API server. Check for high CPU usage, memory leaks or disk I/O issues.

- Look for any networking issues that might be causing high latency. This could include packet loss, high network latency, or problems with network hardware.

## Mitigation

- Monitor the load on your Kubernetes API server and scale it up if needed. This could be done either horizontally (by increasing the number of replicas) or vertically (by increasing the resources allocated to the Kubernetes API server).

- Enable rate limiting to prevent any sudden burst of requests to the Kubernetes API server.

- Regularly check for any performance or resource usage issues and take necessary action before it leads to high latency.

- Regularly review your network performance and take necessary steps to improve it if required.
