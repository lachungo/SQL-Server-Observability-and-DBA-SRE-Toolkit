# Case Study: CPU Scheduler Pressure Investigation

## Environment

- Platform:
- SQL Server version:
- AG topology:
- vCPU before:
- vCPU after:
- Memory:
- Databases:

## Symptom

Users reported:

## Initial Assumptions

Potential causes:
- CPU
- memory
- TempDB
- AG
- storage
- blocking
- monitoring jobs

## Evidence

### Scheduler Pressure

Before:

```text
worst scheduler:
avg runnable:
```

After:

```text
worst scheduler:
avg runnable:
```

### Wait Stats

Before:

```text
SOS_SCHEDULER_YIELD:
CX waits:
```

### Top Queries

Top offender:

```text
procedure:
cpu:
logical reads:
```

### Ruled Out

- Memory:
- TempDB:
- AG:
- Storage:
- Monitoring overhead:

## Root Cause

## Remediation

## Result

## Lessons Learned

## Portfolio Summary

Led evidence-based CPU capacity investigation using scheduler pressure analysis, wait profiling, active workload analysis, and infrastructure scaling validation.
