/*
Purpose:
Show current blocking sessions and blocked sessions.
*/

SELECT
    r.session_id,
    r.blocking_session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    DB_NAME(r.database_id) AS database_name,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.cpu_time / 1000.0 AS cpu_sec,
    r.total_elapsed_time / 1000.0 AS elapsed_sec,
    r.logical_reads,
    t.text AS sql_text
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0
   OR r.wait_type LIKE 'LCK%'
ORDER BY r.wait_time DESC;
