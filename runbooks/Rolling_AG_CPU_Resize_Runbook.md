# Rolling AG CPU Resize Runbook

## Objective
Resize Always On AG nodes with minimum downtime.

## Sequence

1. Confirm secondary synchronized.
2. Resize secondary first.
3. Validate secondary CPU and AG health.
4. Planned failover to resized node.
5. Resize former primary.
6. Validate both nodes.
7. Optionally fail back.

## Pre-checks

Run:

```sql
scripts/ag_health/01_ag_sync_health.sql
scripts/blocking/04_open_transactions.sql
scripts/cpu/03_active_cpu_consumers.sql
```

Go only if:

- no long transactions
- no heavy jobs running
- AG synchronized
- redo/log send queues near zero

## Resize Secondary

In Azure:

```text
Stop/deallocate secondary
Resize VM
Start VM
Validate SQL service
Validate AG rejoined
```

## Validate CPU

Run:

```sql
scripts/health_check/01_instance_baseline.sql
```

## Planned Failover

```sql
ALTER AVAILABILITY GROUP [YourAGName] FAILOVER;
```

## Resize Former Primary

Repeat resize process.

## Post-validation

Run:

```sql
scripts/cpu/01_scheduler_pressure.sql
scripts/ag_health/01_ag_sync_health.sql
scripts/storage_io/01_file_latency.sql
```

## No-Go Triggers

- redo queue growing
- log send queue growing
- long-running write transaction
- active blocking incident
- critical SQL Agent job running
