/*
Purpose:
Show top instance waits, excluding common benign waits.
*/

SELECT TOP (40)
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS wait_seconds,
    signal_wait_time_ms / 1000.0 AS signal_seconds,
    CAST(100.0 * signal_wait_time_ms / NULLIF(wait_time_ms, 0) AS decimal(10,2)) AS signal_wait_pct
FROM sys.dm_os_wait_stats
WHERE wait_type NOT LIKE 'SLEEP%'
  AND wait_type NOT IN
  (
    'BROKER_TASK_STOP','BROKER_TO_FLUSH','SQLTRACE_BUFFER_FLUSH',
    'CLR_AUTO_EVENT','CLR_MANUAL_EVENT','LAZYWRITER_SLEEP',
    'RESOURCE_QUEUE','XE_TIMER_EVENT','XE_DISPATCHER_WAIT',
    'LOGMGR_QUEUE','CHECKPOINT_QUEUE','REQUEST_FOR_DEADLOCK_SEARCH',
    'HADR_FILESTREAM_IOMGR_IOCOMPLETION','DIRTY_PAGE_POLL',
    'SP_SERVER_DIAGNOSTICS_SLEEP','HADR_TIMER_TASK'
  )
ORDER BY wait_time_ms DESC;
