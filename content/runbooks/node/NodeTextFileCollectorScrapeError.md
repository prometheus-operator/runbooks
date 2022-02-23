---
title: Node Text File Collector Scrape Error
weight: 20
---

# NodeTextFileCollectorScrapeError

## Meaning

Node Exporter text file collector failed to scrape.

## Impact

Missing metrics from additional scripts.

## Diagnosis

- Check node_exporter logs
- Check script supervisor (like systemd or cron) for more information about failed script execution

## Mitigation

Check if provided configuration is valid, if files were not renamed during upgrades.
