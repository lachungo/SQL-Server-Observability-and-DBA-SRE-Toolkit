/*
Purpose:
Check read IO and log write waits.
*/

SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS wait_seconds,
    signal_wait_time_ms / 1000.0 AS signal_seconds
FROM sys.dm_os_wait_stats
WHERE wait_type IN
(
    'PAGEIOLATCH_SH',
    'PAGEIOLATCH_EX',
    'PAGEIOLATCH_UP',
    'WRITELOG',
    'IO_COMPLETION',
    'ASYNC_IO_COMPLETION'
)
ORDER BY wait_time_ms DESC;
