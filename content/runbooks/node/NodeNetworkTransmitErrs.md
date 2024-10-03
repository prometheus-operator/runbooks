---
title: Node Network Transmit Errors
weight: 20
---

# NodeNetworkTransmitErrs

## Meaning

Network interface is reporting many transmit errors.

## Impact

Applications on the node may no longer be able to operate with other services.
Network attached storage performance issues or even data loss.

## Diagnosis

Investigate networking issues on the node and to connected hardware.
Check network interface saturation.
Check CPU usage saturation.
Check physical cables, check networking firewall rules and so on.

## Mitigation

In general mitigation landscape is quite vast, some suggestions:

- Ensure some node capacity is left unallocated (cpu/memory) for handling
networking.
- [Increase TX queue length](https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/13/html/ovs-dpdk_end_to_end_troubleshooting_guide/high_packet_loss_in_the_tx_queue_of_the_instance_s_tap_interface)
- Spread services to other nodes/pods.
- Replace physical cables, change ports.
- Look into introducting Quality of Service or other
[TCP congestion avoidance algorithms](https://en.wikipedia.org/wiki/TCP_congestion_control)
