---
title: Node Clock Not Synchronising
weight: 20
---

# NodeClockNotSynchronising

## Meaning

Clock not synchronising.

## Impact

Time is not automatically synchronizing on the node. This can cause issues with handling TLS as well as problems with other time-sensitive applications.

## Diagnosis

1. **Confirm the alert condition**

   ```bash
   timedatectl
   ```

   Look for:

   * `System clock synchronized: no`
   * `NTP service: inactive`

2. **Check the time synchronisation service**
   Most nodes use `chronyd`:

   ```bash
   systemctl status chronyd
   ```

   Common failure modes:

   * Service is stopped or failed
   * Service was OOM-killed
   * No reachable NTP sources


## Mitigation

1. **Restart the time synchronisation service**
   Restarting `chronyd` is safe on production nodes and does not restart workloads.

   ```bash
   sudo systemctl restart chronyd
   ```

2. **Verify the service is running**

   ```bash
   systemctl status chronyd
   ```

3. **Confirm clock synchronisation**

   ```bash
   timedatectl
   ```

   Expected:

   * `System clock synchronized: yes`

4. **If the service was OOM-killed**
   Investigate memory pressure on the node:

   ```bash
   journalctl -k | grep -i oom
   ```

   Consider:

   * Reviewing workload memory limits
   * Adding a small amount of swap as a safety buffer
   * Investigating recent deploys or memory spikes

5. **If the issue persists**
   Follow the mitigation steps in
   [Node Clock Skew Detected](./NodeClockSkewDetected.md)
