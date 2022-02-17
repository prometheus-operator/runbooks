---
title: Config Reloader Sidecar Errors
weight: 20
---

# ConfigReloaderSidecarErrors

## Meaning

Errors encountered while the config-reloader sidecar attempts to sync
config in given namespace.

## Impact

As a result, configuration for service such as prometheus-operator may be
stale and cannot be updated anymore.'

## Diagnosis

Check config-reloader logs, and the app which it tries to manage.

## Mitigation

Usually means new config was rejected by the controlled app because it contains
errors such as unknown configuraction sections, bad resource definitions.

You can prevent such issues with better config testing tools in CI/CD systems
such as:

- [yamllint](https://yamllint.readthedocs.io/en/stable/)
- [yamale](https://github.com/23andMe/Yamale)
- [promtool](https://prometheus.io/docs/prometheus/latest/configuration/unit_testing_rules/)
- [jq](https://stedolan.github.io/jq/)
- yq (notice there is python and golang versions)
- [conftest](https://www.conftest.dev/)
- some apps have syntax checking command switch
