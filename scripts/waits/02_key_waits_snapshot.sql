/*
Purpose:
Focus on waits most relevant to performance incidents.
*/

SELECT
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS wait_seconds,
    signal_wait_time_ms / 1000.0 AS signal_seconds,
    CAST(100.0 * signal_wait_time_ms / NULLIF(wait_time_ms, 0) AS decimal(10,2)) AS signal_wait_pct
FROM sys.dm_os_wait_stats
WHERE wait_type IN
(
    'SOS_SCHEDULER_YIELD',
    'CXPACKET',
    'CXCONSUMER',
    'CXSYNC_PORT',
    'PAGEIOLATCH_SH',
    'PAGEIOLATCH_EX',
    'WRITELOG',
    'RESOURCE_SEMAPHORE',
    'LCK_M_X',
    'LCK_M_IX',
    'LCK_M_S',
    'LCK_M_U',
    'PAGELATCH_EX',
    'PAGELATCH_SH',
    'HADR_SYNC_COMMIT'
)
ORDER BY wait_time_ms DESC;
