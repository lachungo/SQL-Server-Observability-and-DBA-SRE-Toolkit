/*
Purpose:
Detect whether SQL workers are waiting for CPU scheduler time.

Interpretation:
- runnable_tasks_count 0-1: healthy
- 2-3: watch
- 4+: investigate
- 6+: likely pressure
- 10+: severe queueing
*/

SELECT
    GETDATE() AS capture_time,
    scheduler_id,
    cpu_id,
    current_tasks_count,
    runnable_tasks_count,
    active_workers_count,
    work_queue_count,
    load_factor
FROM sys.dm_os_schedulers
WHERE status = 'VISIBLE ONLINE'
ORDER BY runnable_tasks_count DESC, load_factor DESC;
