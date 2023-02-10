# PrometheusMissingRuleEvaluations

## Meaning

Alert fires when Prometheus [`rule_group`](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#rule_group) evaluation takes consistently longer than [`rule_group`'s `interval`](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#rule_group).

## Impact

Rule groups have either alerts or recording rules. If Prometheus can not evaluate rules in time, it might fail to trigger alerts.

## Diagnosis

Quick checks:
- Check if enough resources allocated to Prometheus.
- Check if there are no bad neighbors that consume too much CPU.

Deep dive:
- Use `prometheus_rule_group_iterations_missed_total` metric to identify the struggling rule groups.

## Mitigation

Quick fixes:
- Increase CPU resources allocation to Prometheus.
- Move bad neighbors to different hosts.

Deep dive:
- Increase the [`rule_group`'s evaluation `interval`](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#rule_group).
- Split up up [rule groups](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#rule_group) into smaller groups if rules do not depend on each other. It should help because rules inside a group are evaluated in sequence, whereas groups are evaluated in parallel.
