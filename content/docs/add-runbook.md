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
4. Ensure the file has `.md` extension
5. Fill in the new file following [a template below](#template).
6. Remember to put alert name at the top of the file

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

```text
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

Cross referencing other document:

See [Node RAID Degraded]({ {< ref "../runbooks/node/NodeRAIDDegraded.md" >} })
(remove spaces between curly braces, this was added here to avoid auto-parsing)


[1]: https://github.github.com/gfm/#html-block

(Notice urls are not auto processed yet in Hugo.)

```

### Guidelines

The purpose of this repository is to have a documentation about every alert shipped by kube-prometheus (not only by prometheus-operator). In the long run, we are aiming to support as many k8s flavors as possible. If possible try to ensure the 'Diagnosis/Mitigation' sections are applicable to all certified kubernetes distributions.

The primary target for these runbooks are folks who are novices and don't have much insight into what to do with alerts shipped in kube-prometheus. As a result, try to avoid excessive jargon and abbreviations.

### Testing locally

To test your changes locally:

1. Install [Hugo](https://gohugo.io/getting-started/installing/),
   notice `Extended` version
2. Run `git submodule init` and `git submodule update` to clone the Hugo theme
3. Run `hugo server` for example as container
    from the root of the git repo:

    ```shell
    docker run --rm -it -v $(pwd):/src -p 1313:1313 klakegg/hugo:ext-alpine server
    ```

    and navigate to [localhost:1313](http://localhost:1313/) in your browser.

4. extra scripts in `hack/` to check links (linux specific):

    - `check_urls.sh`: git + grep + wget
    - `spider.sh`: [linkcheck](https://github.com/tennox/linkcheck)
