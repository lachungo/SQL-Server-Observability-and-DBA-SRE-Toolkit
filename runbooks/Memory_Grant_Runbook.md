# Memory Grant Runbook

## Objective
Determine whether queries are waiting for workspace memory or simply using large grants.

## Step 1 - Show active grants

Run:

```sql
scripts/memory/01_active_memory_grants.sql
```

## Step 2 - Show pending grants

Run:

```sql
scripts/memory/02_pending_memory_grants.sql
```

Expected healthy result: zero rows.

## Step 3 - Check RESOURCE_SEMAPHORE waits

Run:

```sql
scripts/memory/03_resource_semaphore_waits.sql
```

## Interpretation

Memory starvation:
- grants waiting
- RESOURCE_SEMAPHORE material
- requested not granted

Overgranting:
- granted memory much greater than used
- usually stats/cardinality/query shape issue

High SQL memory usage alone is not a memory problem.
