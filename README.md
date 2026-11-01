# SQL Server Observability and DBA SRE Toolkit

[![Package integrity](https://github.com/lachungo/SQL-Server-Observability-and-DBA-SRE-Toolkit/actions/workflows/package-integrity.yml/badge.svg)](https://github.com/lachungo/SQL-Server-Observability-and-DBA-SRE-Toolkit/actions/workflows/package-integrity.yml)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2016%20%7C%202019%20%7C%202022-CC2927?logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/sql-server)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An evidence-first collection of SQL Server diagnostic scripts, incident runbooks, operating guidance, and communication templates for database reliability engineering.

> **Monitoring shows that something happened. Engineering explains what happened, why it mattered, and what evidence supports the conclusion.**

## What this repository provides

This toolkit helps a DBA or database reliability engineer perform structured incident triage across the major SQL Server pressure domains:

| Domain | Evidence covered |
|---|---|
| CPU and schedulers | Runnable queues, scheduler pressure, CPU-consuming requests, parallel worker distribution |
| Waits | Top waits and focused operational wait snapshots |
| Blocking | Blocking chains, head blockers, lock hotspots, and open transactions |
| Memory | Active and pending grants, resource semaphore waits, buffer pool usage, and memory configuration |
| TempDB | File layout, session usage, and file latency |
| Storage and I/O | Database-file latency, `PAGEIOLATCH_*`, and `WRITELOG` pressure |
| Always On | Replica health, synchronization state, log-send queues, redo queues, and HADR waits |
| Query tuning | Cached CPU consumers, procedure CPU, logical reads, and missing-index signals |

The repository also includes operational runbooks, a repeatable incident-triage flow, capacity-engineering guidance, leadership communication templates, and a post-incident review template.

## Repository map

```text
SQL-Server-Observability-and-DBA-SRE-Toolkit/
├── .github/workflows/       Package-integrity validation
├── case-studies/            Sanitized case-study template
├── dashboards/              Metrics and baseline guidance
├── docs/                    Operating model and engineering practices
├── runbooks/                Incident-response procedures
├── scripts/                 Read-only diagnostic queries by domain
├── tools/                   Repository validation
├── LICENSE
├── SECURITY.md
└── README.md
```

## Quick start

1. Clone or download the repository.
2. Review [SECURITY.md](SECURITY.md) and the header of every script you plan to run.
3. Connect through SSMS using an account with the minimum permissions required for the relevant DMVs.
4. Run the instance baseline and then the scripts relevant to the observed symptom.
5. Preserve the results with the incident timestamp, server, database, and time window.
6. Use the matching runbook to guide interpretation and escalation.

Suggested first-pass sequence:

```text
scripts/health_check/01_instance_baseline.sql
scripts/cpu/01_scheduler_pressure.sql
scripts/cpu/03_active_cpu_consumers.sql
scripts/waits/01_top_waits.sql
scripts/blocking/01_blocking_chain.sql
scripts/memory/01_active_memory_grants.sql
scripts/storage_io/01_file_latency.sql
scripts/ag_health/01_ag_sync_health.sql  (Always On environments only)
```

Open each script individually in SSMS. SQLCMD `:r` can also be used when SQLCMD mode is enabled.

## Incident triage flow

1. Establish the incident time window and affected workload.
2. Check scheduler pressure and active CPU consumers.
3. Identify blocking chains and open transactions.
4. Review memory grants and resource-semaphore pressure.
5. Inspect TempDB usage and latency.
6. Review database-file and transaction-log latency.
7. Check Always On synchronization and queue health where applicable.
8. Identify expensive cached queries and procedures.
9. Classify the evidence: workload, blocking, memory, storage, availability, application contention, or infrastructure.
10. Document the conclusion, confidence, limitations, and next action.

See [Incident Triage Flow](docs/01_Incident_Triage_Flow.md) for the detailed workflow.

## Operating principles

- Evidence before opinion.
- Preserve the investigation time window.
- Separate symptoms, contributing conditions, and root cause.
- Treat cumulative DMVs as signals that require time context.
- Avoid configuration changes without a baseline, approval, and rollback plan.
- Validate the outcome after every remediation.
- Communicate known facts, remaining uncertainty, and ownership clearly.

## Permissions and compatibility

- Designed for SQL Server 2016, 2019, and 2022.
- Most instance-level DMVs require `VIEW SERVER STATE`.
- SQL Server 2022 may use `VIEW SERVER PERFORMANCE STATE` for some performance DMVs.
- Always On scripts require an Always On-enabled instance and access to HADR metadata.
- DMV availability and permissions can vary by version, edition, and deployment model.
- Review every query in a non-production environment before production use.

## Release scope

This v1 release is a diagnostic and operational toolkit. It does **not** deploy persistent collectors, change SQL Server configuration, remediate incidents automatically, or claim autonomous root-cause determination.

For automated, multi-domain evidence correlation and report generation, see the separate [Agentic AI RCA Toolkit for SQL Server](https://github.com/lachungo/agentic-ai-rca-toolkit).

## Project status

| Capability | Status |
|---|---|
| Read-only domain diagnostics | Included |
| Incident and war-room runbooks | Included |
| Capacity and communication guidance | Included |
| Automated package validation | Included |
| Persistent telemetry collection | Not included |
| Historical baseline engine | Planned |
| Consolidated HTML assessment | Planned |
| Automatic remediation | Out of scope for v1 |

## Safety notice

These scripts are provided for engineering assessment, demonstration, and controlled evaluation. Validate permissions, version compatibility, workload impact, and result interpretation before production use. Read-only queries can still consume resources on busy instances.

Missing-index DMVs, wait statistics, cached-plan DMVs, and cumulative counters must not be treated as stand-alone proof of root cause.

Diagnostic output may contain sensitive query text, object names, login details, or infrastructure information. Review and sanitize results before sharing.

## Implementation and Support

Review and adapt the scripts and runbooks to the target environment. Recommendations require DBA judgment and validation against workload requirements and organizational change procedures.

For environment-specific assessment, implementation guidance, or customization, contact [Louis Achungo on LinkedIn](https://www.linkedin.com/in/louis-achungo/).

## 🔗 Connect

- 🌐 Portfolio: https://sql-it-techsolutions.com/  
- 💼 LinkedIn: https://linkedin.com/in/louis-achungo  

---

⭐ If this helped, consider starring the repo.

---

**Louis Achungo**  
Principal SQL Server Architect | Performance Engineering | HA/DR | Azure SQL & AWS

*Building reliable, observable, and scalable database platforms through architecture, automation, and operational excellence.*


## License

Released under the [MIT License](LICENSE).
