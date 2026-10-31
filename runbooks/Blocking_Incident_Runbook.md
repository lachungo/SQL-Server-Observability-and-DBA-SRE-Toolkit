# Blocking Incident Runbook

## Objective
Identify head blocker, lock object, transaction age, and application source.

## Step 1 - Show blocking chain

Run:

```sql
scripts/blocking/01_blocking_chain.sql
```

## Step 2 - Identify head blocker

Run:

```sql
scripts/blocking/02_head_blocker_details.sql
```

## Step 3 - Review input buffer

```sql
DBCC INPUTBUFFER(<session_id>);
```

## Step 4 - Identify lock hotspot

Run:

```sql
scripts/blocking/03_lock_hotspots.sql
```

## Step 5 - Check open transactions

Run:

```sql
scripts/blocking/04_open_transactions.sql
```

## Actions

- If app transaction is holding locks too long, escalate to app owner.
- If missing index causes long update/scan, tune index.
- If session is abandoned, follow operational policy for termination.
- If pattern repeats, implement blocking alert and blocked process report Extended Event.
