# CPU Pressure Runbook

## Objective
Determine whether SQL Server is CPU constrained and whether the cause is capacity or query workload.

## Step 1 - Confirm runnable queue

Run:

```sql
scripts/cpu/01_scheduler_pressure.sql
```

Pay attention to:

- worst scheduler
- total runnable tasks
- number of schedulers affected

## Step 2 - Confirm SOS_SCHEDULER_YIELD

Run:

```sql
scripts/cpu/02_sos_scheduler_yield.sql
```

High signal wait percentage plus runnable queues is strong CPU evidence.

## Step 3 - Identify active CPU consumers

Run:

```sql
scripts/cpu/03_active_cpu_consumers.sql
```

Look for:

- top CPU seconds
- high elapsed seconds
- high logical reads
- DOP
- host and login

## Step 4 - Identify stored procedure offenders

Run:

```sql
scripts/query_tuning/02_top_procedures_by_cpu.sql
```

## Step 5 - Rule out other causes

Run:

- memory grants
- TempDB
- storage latency
- AG sync health
- blocking chain

## Decision

If CPU pressure remains after ruling out memory, TempDB, storage, AG, and blocking:

- tune top procedures
- reduce logical reads
- review indexes/stats
- consider compute scaling
