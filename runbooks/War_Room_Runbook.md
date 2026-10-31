# SQL Performance War Room Runbook

## Purpose
Standard sequence for live performance incidents.

## Step 1 - State the problem

Capture:
- who is impacted
- when it started
- which app/module
- error messages
- whether all users or subset

## Step 2 - Run triage scripts

1. CPU scheduler pressure
2. Active sessions
3. Blocking chain
4. Wait stats
5. Memory grants
6. TempDB
7. Storage IO
8. AG health

## Step 3 - Categorize

| Symptom | Likely Area |
|---|---|
| Runnable queues high | CPU |
| LCK waits | Blocking |
| PAGEIOLATCH | Read IO |
| WRITELOG | Log IO |
| RESOURCE_SEMAPHORE | Memory grants |
| Redo/log queues | AG |
| One proc dominates | Query tuning |

## Step 4 - Communicate

Use docs/03_Leadership_Communication_Templates.md.

## Step 5 - Capture evidence

Save screenshots and query outputs.

## Step 6 - Decide containment

Options:
- pause job
- throttle workload
- failover
- scale compute
- tune query
- create index after review
- engage app owner

## Step 7 - Post-incident review

Use docs/04_Post_Incident_Review_Template.md.
