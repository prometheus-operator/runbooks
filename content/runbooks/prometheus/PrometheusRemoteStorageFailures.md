---
title: Prometheus Remote Storage Failures
weight: 20
---

# PrometheusRemoteStorageFailures

## Meaning

Prometheus fails to send samples to remote storage.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis

Check prometheus logs and remote storage logs.
Investigate network issues.
Check configs and credentials.

**Common Causes**
* **Network Connectivity:** Issues between the Prometheus instance and the remote storage endpoint (e.g., DNS failures, firewall blocks, or transient network timeouts).
* **Remote Storage Overload:** The receiving system is saturated and returning 429 (Too Many Requests) or 5xx errors.
* **Configuration/Authentication:** Invalid API keys, expired certificates, or incorrect endpoint URLs in the remote_write configuration. ( This should be seen as a `401` based error in the logs )
* **Sample Rejection:** The remote storage is rejecting specific samples due to "out of order" timestamps or "duplicate" labels.
  * **Duplicate Timestamps:** There are two common scenarios where you can trigger duplicate / dedupe errors.
     * **Coalesed Series:** Errors show up right after making changes to try and reduce cardinality
        ```shell
        # Example error log
        ts=2026-02-18T22:04:20.647Z caller=dedupe.go:112 component=remote level=error remote_name=dfa7a0 url="https://<remote-storage-endpoint-url>/api/v1/write" msg="non-recoverable error" failedSampleCount=700 failedHistogramCount=0 failedExemplarCount=0 err="server returned HTTP status 400 Bad Request: maxFailure (quorum) on a given error family, addr=<ipAddress:port> state=ACTIVE zone=, rpc error: code = Code(400) desc = user=<username>: err: duplicate sample for timestamp 1771452258303; overrides not allowed: existing 9, new value 548. series={__name__=\"prometheus_sd_updates_total\", cluster=\"<k8sCluster>\", container=\"prometheus\", endpoint=\"http-web\", instance=\"<ipAddress:port>\", job=\"app-promoperator-prometheus\", namespace=\"<namespace>\", pod=\"prometheus-app-promoperator-prometheus-0\", prometheus=\"<promethus-cluster>\", service=\"app-promoperator-prometheus\"}\n"
        ```

        This specific error was caused by dropping too many labels in the [Prometheus Remote Write configs](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config). It ended up coalescing two unique series when sending, so it was first trying to send one series and then overwrote it with the next one with the exact same timestamp. Below is an example of what this can look like.

        ```shell
        # Example series scraped by Prometheus
        node_cpu_seconds_total{mode="idle"} 100
        node_cpu_seconds_total{mode="system"} 600
        ```
        While the name of metric is the same, the different lables makes these two unique series. Prometheus will push these as two unique series to your remote storage URL. If you were to drop the `mode` label from the series, you coalesce it and create a duplicate entry.

        ```shell
        # Example series sent from Prometheus to remote storage via Remote Write
        node_cpu_seconds_total{} 100
        node_cpu_seconds_total{} 600
        ```
  * **Out of Order:**
    * **Time Synchronization Issue:** Inconsistent system clocks between the sending Prometheus instance/exporter and the receiving system (like Mimir, Cortex, or another Prometheus) can cause samples to be perceived as arriving out of order. This should be rare when using Ethos, but can be an issue when running agents on VM or bare metal deployments.
      * **Solution:** Ensure all machines involved have their clocks synchronized using a service like `chrony` or `ntp`.
    * **Duplicate Series due to Misconfiguration:** If the same metric is scraped by multiple Prometheus instances or exporters without unique `external_labels`, the receiving end sees duplicate data streams that conflict on arrival order.
      * **Solution:** Ensure each Prometheus server or agent has a unique `external_labels` configuration to distinguish its data. See below for a common `external_labels` configuration.

          **Server01**
          ```yaml
          # Prometheus server 01
          global:
            external_labels:
              cluster: prom-team1
              __replica__: replica1
          ```
          **Server02**
          ```yaml
          # Prometheus server 02
          global:
            external_labels:
              cluster: prom-team1
              __replica__: replica2
          ```

      * **Solution:** Review relabeling configurations to ensure unique time series are not accidentally coalesced into having the same label set.
    * **Prometheus Restarts:** After a restart, a Prometheus instance might replay samples from its Write-Ahead Log (WAL) that the remote endpoint has already received, leading to errors as the old data is seen as out-of-order. This is often the most common cause of these errors. As the WAL is replayed, you will get a small burst of these errors, just enought to breech the alert threshold and it will typically clear when the WAL is caught back up.
    * **Solution:** This is generally a transient issue that resolves itself once the WAL replay is complete.
