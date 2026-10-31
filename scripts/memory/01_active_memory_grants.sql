/*
Purpose:
Show active query memory grants.

Key interpretation:
- grant_time NULL means waiting for memory.
- requested = granted means grant satisfied.
- granted much greater than used may indicate overgranting.
*/

SELECT
    GETDATE() AS capture_time,
    mg.session_id,
    mg.request_time,
    mg.grant_time,
    mg.requested_memory_kb / 1024 AS requested_mb,
    mg.granted_memory_kb / 1024 AS granted_mb,
    mg.used_memory_kb / 1024 AS used_mb,
    mg.max_used_memory_kb / 1024 AS max_used_mb,
    (mg.granted_memory_kb - mg.used_memory_kb) / 1024 AS unused_grant_mb,
    mg.dop,
    mg.wait_time_ms,
    s.login_name,
    s.host_name,
    DB_NAME(r.database_id) AS database_name,
    r.wait_type,
    r.status,
    t.text AS sql_text
FROM sys.dm_exec_query_memory_grants mg
LEFT JOIN sys.dm_exec_sessions s
    ON mg.session_id = s.session_id
LEFT JOIN sys.dm_exec_requests r
    ON mg.session_id = r.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
ORDER BY mg.requested_memory_kb DESC;
