/*
Purpose:
Identify active sessions currently consuming CPU, logical reads, and elapsed time.
*/

SELECT TOP (50)
    GETDATE() AS capture_time,
    r.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    DB_NAME(r.database_id) AS database_name,
    r.status,
    r.command,
    r.cpu_time / 1000.0 AS cpu_sec,
    r.total_elapsed_time / 1000.0 AS elapsed_sec,
    r.logical_reads,
    r.reads,
    r.writes,
    r.wait_type,
    r.wait_time,
    r.last_wait_type,
    r.blocking_session_id,
    r.dop,
    SUBSTRING
    (
        t.text,
        (r.statement_start_offset / 2) + 1,
        CASE
            WHEN r.statement_end_offset = -1
                THEN LEN(CONVERT(nvarchar(max), t.text))
            ELSE (r.statement_end_offset - r.statement_start_offset) / 2 + 1
        END
    ) AS active_statement,
    t.text AS full_batch_text
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id <> @@SPID
  AND s.is_user_process = 1
ORDER BY r.cpu_time DESC, r.logical_reads DESC, r.total_elapsed_time DESC;
