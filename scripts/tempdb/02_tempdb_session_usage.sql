/*
Purpose:
Identify sessions consuming TempDB space.
*/

SELECT TOP (50)
    s.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    (su.user_objects_alloc_page_count * 8) / 1024 AS user_object_alloc_mb,
    (su.internal_objects_alloc_page_count * 8) / 1024 AS internal_object_alloc_mb,
    ((su.user_objects_alloc_page_count + su.internal_objects_alloc_page_count) * 8) / 1024 AS total_tempdb_alloc_mb,
    r.status,
    r.command,
    r.wait_type,
    t.text AS sql_text
FROM sys.dm_db_session_space_usage su
JOIN sys.dm_exec_sessions s
    ON su.session_id = s.session_id
LEFT JOIN sys.dm_exec_requests r
    ON su.session_id = r.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE s.session_id > 50
ORDER BY total_tempdb_alloc_mb DESC;
