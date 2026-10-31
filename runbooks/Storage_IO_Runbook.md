# Storage IO Runbook

## Objective
Determine whether user slowness is caused by storage latency.

## Step 1 - Check file latency

Run:

```sql
scripts/storage_io/01_file_latency.sql
```

Rules of thumb:
- <5 ms excellent
- 5-15 ms acceptable
- 15-30 ms concerning
- >30 ms serious

## Step 2 - Check IO waits

Run:

```sql
scripts/storage_io/02_pageiolatch_writelog_waits.sql
```

## Interpretation

PAGEIOLATCH:
- data read latency or excessive physical reads

WRITELOG:
- log write latency or high transaction volume

Actions:
- tune queries to reduce reads
- validate storage performance
- review log file placement
- check backup/index workloads
