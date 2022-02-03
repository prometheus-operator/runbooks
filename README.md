# Prometheus-Operator Runbooks

This repo contains the official [runbooks](https://en.wikipedia.org/wiki/Runbook) for the various alerts sent out by components of the prometheus-operator ecosystem.

The live version can be found at https://runbooks.prometheus-operator.dev/

## Contributing

To edit or expand an existing runbook, feel free to edit the files under `content/` and submit a pull request.

To create a new runbook, see [add-runbook.md](./content/docs/add-runbook.md).


## Guidelines

The purpose of this repository is to have a documentation about every alert shipped by kube-prometheus (not only by prometheus-operator). In the long run, we are aiming to support as many k8s flavors as possible. If possible try to ensure the 'Diagnosis/Mitigation' sections are applicable to all certified kubernetes distributions.

The primary target for these runbooks are folks who are novices and don't have much insight into what to do with alerts shipped in kube-prometheus. As a result, try to avoid excessive jargon and abbreviations.
