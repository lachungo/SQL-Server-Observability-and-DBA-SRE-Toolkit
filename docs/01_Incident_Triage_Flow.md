# Incident Triage Flow

## Step 1 - Confirm CPU Scheduler State

Run:

```sql
scripts/cpu/01_scheduler_pressure.sql
scripts/cpu/02_sos_scheduler_yield.sql
```

Interpretation:

- `runnable_tasks_count` 0-1: healthy
- 2-3: watch
- 4+: investigate
- 6+: likely pressure
- 10+: severe queueing

## Step 2 - Identify Active Offenders

Run:

```sql
scripts/cpu/03_active_cpu_consumers.sql
scripts/query_tuning/01_top_cpu_cached_queries.sql
scripts/query_tuning/02_top_procedures_by_cpu.sql
```

Look for:

- high CPU seconds
- high logical reads
- high elapsed time
- repeated procedures
- parallel DOP usage

## Step 3 - Check Blocking

Run:

```sql
scripts/blocking/01_blocking_chain.sql
scripts/blocking/02_head_blocker_details.sql
scripts/blocking/03_lock_hotspots.sql
```

Look for:

- `LCK_M_X`
- `LCK_M_IX`
- `LCK_M_U`
- a single head blocker
- long open transactions

## Step 4 - Check Memory Grants

Run:

```sql
scripts/memory/01_active_memory_grants.sql
scripts/memory/02_pending_memory_grants.sql
scripts/memory/03_resource_semaphore_waits.sql
```

Memory pressure exists if:

- grants are waiting
- `grant_time IS NULL`
- `RESOURCE_SEMAPHORE` waits are material

Overgranting exists if:

- granted memory is much higher than used memory

## Step 5 - Check TempDB

Run:

```sql
scripts/tempdb/01_tempdb_files.sql
scripts/tempdb/02_tempdb_session_usage.sql
scripts/tempdb/03_tempdb_file_latency.sql
```

Look for:

- uneven file sizes
- percent growth
- high write latency
- session-level temp usage spikes

## Step 6 - Check Storage IO

Run:

```sql
scripts/storage_io/01_file_latency.sql
scripts/storage_io/02_pageiolatch_writelog_waits.sql
```

Look for:

- data file reads > 15-20 ms
- log writes > 5-10 ms for sensitive OLTP systems
- PAGEIOLATCH waits
- WRITELOG waits

## Step 7 - Check AG Health

Run:

```sql
scripts/ag_health/01_ag_sync_health.sql
scripts/ag_health/02_hadr_sync_commit.sql
scripts/ag_health/03_replica_health.sql
```

Look for:

- log send queue growth
- redo queue growth
- synchronization not healthy
- sync commit dominating waits

## Step 8 - Decide Root Cause Category

| Category | Evidence |
|---|---|
| CPU capacity | runnable queues + SOS_SCHEDULER_YIELD |
| Query tuning | high logical reads + one/few procs |
| Blocking | LCK waits + head blocker |
| Memory grants | pending grants + RESOURCE_SEMAPHORE |
| TempDB | high temp usage + PAGELATCH/temp latency |
| Storage | PAGEIOLATCH/WRITELOG + file latency |
| AG | queues/redo lag/sync commit dominance |
