# TargetDown

## Meaning

The alert means that one or more prometheus scrape targets are down. It fires when at least 10% of scrape targets in a Service are unreachable.

## Impact

Metrics from a particular target cannot be scraped as such there is no data for this target in Prometheus and alerting can be hindered.

## Diagnosis

`/targets` page in Prometheus UI can be used to check the scrape error for the particular target.

`up == 0` query can be used to check the trend over time.

## Mitigation

Mitigation depends on the error reported by prometheus and there is no generic one.