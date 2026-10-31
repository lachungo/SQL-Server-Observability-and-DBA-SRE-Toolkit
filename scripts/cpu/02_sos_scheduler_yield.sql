/*
Purpose:
Show SOS_SCHEDULER_YIELD wait information.

Meaning:
Workers voluntarily yielded and are waiting to get back on CPU.
High signal wait percentage plus high runnable queues supports CPU pressure.
*/

SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS wait_seconds,
    signal_wait_time_ms / 1000.0 AS signal_seconds,
    CAST(100.0 * signal_wait_time_ms / NULLIF(wait_time_ms, 0) AS decimal(10,2)) AS signal_wait_pct
FROM sys.dm_os_wait_stats
WHERE wait_type = 'SOS_SCHEDULER_YIELD';
