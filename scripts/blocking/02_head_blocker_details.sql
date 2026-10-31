/*
Purpose:
Identify head blockers: sessions blocking others that are not themselves blocked.
*/

;WITH blockers AS
(
    SELECT DISTINCT blocking_session_id
    FROM sys.dm_exec_requests
    WHERE blocking_session_id <> 0
)
SELECT
    b.blocking_session_id AS head_blocker_session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    s.status,
    s.open_transaction_count,
    s.last_request_start_time,
    s.last_request_end_time,
    c.client_net_address
FROM blockers b
JOIN sys.dm_exec_sessions s
    ON b.blocking_session_id = s.session_id
LEFT JOIN sys.dm_exec_connections c
    ON s.session_id = c.session_id
LEFT JOIN sys.dm_exec_requests r
    ON b.blocking_session_id = r.session_id
WHERE ISNULL(r.blocking_session_id, 0) = 0;
