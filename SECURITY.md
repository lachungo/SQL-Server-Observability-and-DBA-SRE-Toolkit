# Security and Production-Safety Policy

## Before production use

- Review each script and its target scope.
- Test against a representative non-production SQL Server instance.
- Use a least-privileged diagnostic account.
- Confirm DMV permissions and SQL Server version compatibility.
- Capture the server, database, incident window, and execution timestamp.
- Do not interpret cumulative waits, cached plans, or missing-index DMVs without time context.
- Do not turn a diagnostic observation directly into a production change without approval, impact analysis, and rollback planning.

The included SQL files are intended to be read-only diagnostics. Any future state-changing operation must be isolated, clearly labeled, documented with prerequisites, and accompanied by validation and rollback instructions.

## Sensitive information

Do not commit customer or employer data, production identifiers, sensitive query text, unredacted plans, credentials, connection strings, tokens, private keys, screenshots, incident logs, or exported monitoring data. Sanitize all examples and case studies before publication.

## Reporting a concern

Do not open a public issue for a suspected security vulnerability. Contact the repository owner through the professional links on the GitHub profile and provide the affected file, risk, reproduction details, and recommended mitigation.
