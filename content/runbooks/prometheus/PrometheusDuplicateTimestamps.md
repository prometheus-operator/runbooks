---
title: Prometheus Duplicate Timestamps
weight: 20
---

# PrometheusDuplicateTimestamps

Find the Prometheus Pod that concerns this.

```shell
$ kubectl -n <namespace> get pod
prometheus-k8s-0                       2/2     Running   1          122m
prometheus-k8s-1                       2/2     Running   1          122m
```

Look at the logs of each of them, there should be a log line such as:

```shell
$ kubectl -n <namespace> logs prometheus-k8s-0
level=warn ts=2021-01-04T15:08:55.613Z caller=scrape.go:1372 component="scrape manager" scrape_pool=default/main-ingress-nginx-controller/0 target=http://10.0.7.3:10254/metrics msg="Error on ingesting samples with different value but same timestamp" num_dropped=16
```

Now there is a judgement call to make, this could be the result of:

* Faulty configuration, which could be resolved by removing the offending
  `ServiceMonitor` or `PodMonitor` object, which can be identified through
  the `scrape_pool` label in the log line, which is in the format of
  `<namespace>/<service-monitor-name>/<endpoint-id>`.

* The target is reporting faulty data, sometimes this can be resolved by
  restarting the target, or it might need to be fixed in code of the offending
  application.

You can use the script below to find duplicated metrics:

```
#!/bin/bash

# get metrics for analyse
curl http://10.0.7.3:10254/metrics > webpage.txt

awk '{print $1}' webpage.txt | sort | uniq -d | while read line; do
    echo "duplicatedmetric: $line"
    grep "$line" webpage.txt
done
```

Further reading [blog](https://www.robustperception.io/debugging-out-of-order-samples)
