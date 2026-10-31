# TempDB Runbook

## Objective
Determine whether TempDB is a bottleneck.

## Step 1 - Check file layout

Run:

```sql
scripts/tempdb/01_tempdb_files.sql
```

Healthy:
- multiple equal data files
- same growth
- fixed MB growth
- no percent growth

## Step 2 - Find TempDB heavy sessions

Run:

```sql
scripts/tempdb/02_tempdb_session_usage.sql
```

## Step 3 - Check TempDB latency

Run:

```sql
scripts/tempdb/03_tempdb_file_latency.sql
```

## Interpretation

Concern:
- high write latency
- one session consuming huge tempdb
- PAGELATCH_EX/SH contention
- spills from query plans

Actions:
- tune temp-heavy queries
- check file layout
- check storage tier
- review spills
