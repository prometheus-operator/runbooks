---
title: Node High Number Conntrack Entries Used
weight: 20
---

# NodeHighNumberConntrackEntriesUsed

## Meaning

Number of conntrack are getting close to the limit.

## Impact

When reached the limit then some connections will be dropped, degrading service quality.

## Diagnosis

Check current conntrack value on the node.
Check which apps are generating a lot of connections.

## Mitigation

Migrate some pods to another nodes.
Bump conntrack limit directly on the node.
Update provisioning scripts to do the same on node start.
