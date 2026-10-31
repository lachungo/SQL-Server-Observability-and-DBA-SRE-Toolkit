/*
Purpose:
Check whether synchronous commit waits are material.
*/

SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS wait_seconds,
    signal_wait_time_ms / 1000.0 AS signal_seconds,
    CAST(100.0 * signal_wait_time_ms / NULLIF(wait_time_ms, 0) AS decimal(10,2)) AS signal_wait_pct
FROM sys.dm_os_wait_stats
WHERE wait_type = 'HADR_SYNC_COMMIT';
