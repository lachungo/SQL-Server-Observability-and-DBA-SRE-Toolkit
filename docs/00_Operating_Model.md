# DBA SRE Operating Model

## Mission

The DBA SRE function owns reliability, scalability, performance, and operational confidence for SQL Server platforms.

## Responsibilities

- Production performance triage
- Always On AG operational health
- Capacity planning and right-sizing
- Observability and alerting
- Query and workload diagnostics
- Incident documentation
- Post-incident improvement plans
- Automation-first operational practices

## Operating Principles

1. **Start broad, narrow quickly.**
2. **Measure before acting.**
3. **Do not confuse high utilization with pressure.**
4. **Differentiate infrastructure bottlenecks from query inefficiency.**
5. **Use before/after metrics for every major change.**
6. **Document decisions, not just symptoms.**

## Incident Severity Lens

| Severity | Description | Examples |
|---|---|---|
| SEV1 | Business-critical outage | AG down, app unavailable |
| SEV2 | Significant degradation | CPU saturation, blocking storm |
| SEV3 | Localized degradation | one report slow, isolated blocking |
| SEV4 | Investigation / baseline | trend analysis, optimization |

## Standard War Room Questions

- What changed?
- Is the issue system-wide or workload-specific?
- Are tasks waiting for CPU?
- Are users blocked?
- Is IO slow?
- Is AG synchronized?
- Is memory under pressure?
- Which procedure or application is responsible?
- What is the safest immediate containment?
- What is the permanent fix?
