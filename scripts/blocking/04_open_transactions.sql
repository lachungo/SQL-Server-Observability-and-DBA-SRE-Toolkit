/*
Purpose:
Find open transactions that may be holding locks.
*/

DBCC OPENTRAN;

SELECT
    at.transaction_begin_time,
    DATEDIFF(MINUTE, at.transaction_begin_time, GETDATE()) AS tran_age_minutes,
    st.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    s.status,
    s.open_transaction_count
FROM sys.dm_tran_active_transactions at
JOIN sys.dm_tran_session_transactions st
    ON at.transaction_id = st.transaction_id
JOIN sys.dm_exec_sessions s
    ON st.session_id = s.session_id
ORDER BY at.transaction_begin_time;
