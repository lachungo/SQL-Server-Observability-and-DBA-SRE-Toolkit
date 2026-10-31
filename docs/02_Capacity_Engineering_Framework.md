# Capacity Engineering Framework

## Purpose

Use this framework when making a case for vCPU, memory, storage, or architecture changes.

## CPU Capacity Evidence

Collect:

```sql
scripts/cpu/01_scheduler_pressure.sql
scripts/cpu/02_sos_scheduler_yield.sql
scripts/cpu/03_active_cpu_consumers.sql
scripts/query_tuning/02_top_procedures_by_cpu.sql
```

Strong CPU case exists when:

- runnable queues are repeatedly elevated
- SOS_SCHEDULER_YIELD signal wait is high
- top queries show high CPU
- memory, TempDB, storage, and AG are ruled out
- workload concurrency is business-required

## Memory Capacity Evidence

Collect:

```sql
scripts/memory/01_active_memory_grants.sql
scripts/memory/02_pending_memory_grants.sql
scripts/memory/04_buffer_pool_by_database.sql
scripts/memory/05_page_life_expectancy.sql
```

Strong memory case exists when:

- memory grants queue
- RESOURCE_SEMAPHORE waits are material
- PLE collapses repeatedly
- OS available memory is low
- paging occurs

High memory usage alone is not a memory issue in SQL Server.

## Storage Capacity Evidence

Collect:

```sql
scripts/storage_io/01_file_latency.sql
scripts/storage_io/02_pageiolatch_writelog_waits.sql
```

Strong storage case exists when:

- file latency is consistently elevated
- PAGEIOLATCH or WRITELOG dominate
- workload cannot be tuned sufficiently
- storage tier is below workload demand

## AG Capacity Evidence

Collect:

```sql
scripts/ag_health/01_ag_sync_health.sql
scripts/ag_health/02_hadr_sync_commit.sql
```

Strong AG case exists when:

- redo queue grows
- log send queue grows
- sync commit dominates
- secondary cannot keep up
- network/harden/redo path is bottlenecked

## Decision Table

| Evidence | Recommendation |
|---|---|
| CPU queues improved after scaling | scale was justified |
| CPU queues low but users slow | investigate blocking/query/IO |
| Memory grants satisfied | memory not primary |
| AG queues zero | AG sync not primary |
| File latency low | storage not primary |
| One proc dominates CPU | tune procedure |
