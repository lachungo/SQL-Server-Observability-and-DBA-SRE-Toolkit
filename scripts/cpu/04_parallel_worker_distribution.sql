/*
Purpose:
Show which requests are using multiple worker tasks across schedulers.
Useful for CXPACKET, CXCONSUMER, and CXSYNC_PORT investigations.
*/

SELECT
    session_id,
    request_id,
    COUNT(*) AS worker_tasks,
    MIN(scheduler_id) AS min_scheduler,
    MAX(scheduler_id) AS max_scheduler
FROM sys.dm_os_tasks
WHERE session_id IS NOT NULL
GROUP BY session_id, request_id
HAVING COUNT(*) > 1
ORDER BY worker_tasks DESC;
