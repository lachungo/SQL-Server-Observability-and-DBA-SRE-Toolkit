# Post Incident Review Template

## Incident Summary

Date:
Environment:
Primary Server:
Application:
Databases impacted:

## User Impact

Describe symptoms:
- slowness
- timeouts
- failed jobs
- blocking
- application delays

## Timeline

| Time | Event |
|---|---|
| | User report |
| | Initial DMV checks |
| | Root cause identified |
| | Mitigation |
| | Validation |
| | Closure |

## Evidence Collected

- Scheduler pressure:
- Top CPU sessions:
- Wait stats:
- Blocking:
- Memory grants:
- TempDB:
- Storage IO:
- AG health:

## Root Cause

Primary cause:

Secondary contributors:

Ruled out:

## Immediate Mitigation

What was done:

## Permanent Fix

- query tuning
- index changes
- stats updates
- app change
- infrastructure scaling
- alerting enhancement

## Lessons Learned

## Follow-up Actions

| Owner | Action | Due Date |
|---|---|---|
| | | |
