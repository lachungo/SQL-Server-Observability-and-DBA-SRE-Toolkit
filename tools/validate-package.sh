#!/usr/bin/env bash
set -euo pipefail

required_files=(
  "README.md"
  "LICENSE"
  "SECURITY.md"
  "VERSION_MANIFEST.md"
  "docs/01_Incident_Triage_Flow.md"
  "runbooks/CPU_Pressure_Runbook.md"
  "scripts/health_check/01_instance_baseline.sql"
)

for file in "${required_files[@]}"; do
  if [[ ! -s "$file" ]]; then
    echo "Required file is missing or empty: $file" >&2
    exit 1
  fi
done

sql_count=$(find scripts -type f -name '*.sql' | wc -l | tr -d ' ')
runbook_count=$(find runbooks -type f -name '*.md' | wc -l | tr -d ' ')

if (( sql_count < 29 )); then
  echo "Expected at least 29 SQL scripts; found $sql_count" >&2
  exit 1
fi

if (( runbook_count < 8 )); then
  echo "Expected at least 8 runbooks; found $runbook_count" >&2
  exit 1
fi

if grep -RInE '^(<<<<<<<|=======|>>>>>>>)' . --exclude-dir=.git; then
  echo "Unresolved merge-conflict markers found." >&2
  exit 1
fi

if find scripts -type f -name '*.sql' -empty | grep -q .; then
  echo "One or more SQL scripts are empty." >&2
  exit 1
fi

echo "Package validation passed: $sql_count SQL scripts and $runbook_count runbooks."
