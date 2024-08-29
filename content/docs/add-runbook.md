---
title: Add Runbook
menu:
  after:
    weight: -100
---

# Adding new runbook

## How?

1. [Figure out alert category from the alert name](#finding-correct-component)
2. Open a PR with new file placed in correct component subdirectory. You can use
[links below to open a PR directly](#pr-links)
3. Name the new file the same as the alert it describes
4. Fill in the new file following [a template below](#template).
5. Remember to put alert name at the top of the file

### Finding correct component

All alerts are prefixed with a name of the component. If the alert is not prefixed, it should go into "general"
component category.

For example `KubeStateMetricsListErrors` suggest it is a kube-state-metrics alert, but `Watchdog` is a "general" one.

### PR links

- [New alertmanager runbook]({{< param BookRepo >}}/new/main/content/runbooks/alertmanager)
- [New kube-state-metrics runbook]({{< param BookRepo >}}/new/main/content/runbooks/kube-state-metrics)
- [New kubernetes runbook]({{< param BookRepo >}}/new/main/content/runbooks/kubernetes)
- [New node runbook]({{< param BookRepo >}}/new/main/content/runbooks/node)
- [New prometheus runbook]({{< param BookRepo >}}/new/main/content/runbooks/prometheus)
- [New prometheus-operator runbook]({{< param BookRepo >}}/new/main/content/runbooks/prometheus-operator)
- [New general runbook]({{< param BookRepo >}}/new/main/content/runbooks/general)

## Template

Runbook example based on a NodeFilesystemSpaceFillingUp (thanks to @beorn7):

```
# NodeFilesystemSpaceFillingUp

## Meaning

This alert is based on an extrapolation of the space used in a file system. It fires if both the current usage is above a certain threshold _and_ the extrapolation predicts to run out of space in a certain time. This is a warning-level alert if that time is less than 24h. It's a critical alert if that time is less than 4h.

<details>
<summary>Full context</summary>

Here is where you can optionally describe some more details about the alert. The "meaning" is the short version for an on-call engineer to quickly read through. The "details" are for learning about the bigger picture or the finer details.

> NOTE: The blank lines above and below the text inside this `<details>` tag are [required to use markdown inside of html tags][1]

</details>

## Impact

A filesystem running completely full is obviously very bad for any process in need to write to the filesystem. But even before a filesystem runs completely full, performance is usually degrading.

## Diagnosis

Study the recent trends of filesystem usage on a dashboard. Sometimes a periodic pattern of writing and cleaning up can trick the linear prediction into a false alert.

Use the usual OS tools to investigate what directories are the worst and/or recent offenders.

Is this some irregular condition, e.g. a process fails to clean up behind itself, or is this organic growth?

## Mitigation

<Insert site specific measures, for example to grow a persistent volume.>


[1]: https://github.github.com/gfm/#html-block
```

### Guidelines

The purpose of this repository is to have a documentation about every alert shipped by kube-prometheus (not only by prometheus-operator). In the long run, we are aiming to support as many k8s flavors as possible. If possible try to ensure the 'Diagnosis/Mitigation' sections are applicable to all certified kubernetes distributions.

The primary target for these runbooks are folks who are novices and don't have much insight into what to do with alerts shipped in kube-prometheus. As a result, try to avoid excessive jargon and abbreviations.

### Testing locally

To test your changes locally:

1. Run `git submodule update --init --remote` to clone the Hugo theme.
2. Either use [Nix](https://nixos.org/) or install required tools locally:
   1. Install [Nix](https://nixos.org/download/) (command is `sh <(curl -L https://nixos.org/nix/install)` on MacOS) and run `nix-shell --run $SHELL` - first run will take a while.
   2. Install [Hugo](https://gohugo.io/getting-started/installing/).
3. Run `hugo server` and navigate to `http://localhost:1313/` in your browser
