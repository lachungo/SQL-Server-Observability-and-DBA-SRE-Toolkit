# Always On AG Runbook

## Objective
Determine whether AG synchronization contributes to slowness or failover risk.

## Step 1 - Check AG synchronization

Run:

```sql
scripts/ag_health/01_ag_sync_health.sql
```

Healthy:
- SYNCHRONIZED
- HEALTHY
- log send queue near zero
- redo queue near zero

## Step 2 - Check sync commit waits

Run:

```sql
scripts/ag_health/02_hadr_sync_commit.sql
```

## Step 3 - Check replica health

Run:

```sql
scripts/ag_health/03_replica_health.sql
```

## Interpretation

AG is not likely cause when:
- queues are near zero
- estimated redo delay is zero/low
- replicas healthy
- HADR_SYNC_COMMIT is not dominant

AG issue likely when:
- redo queue grows
- log send queue grows
- secondary cannot keep up
- connection errors appear
