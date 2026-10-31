/*
Purpose:
Check Always On AG log send and redo health.
Run from the primary for best view.
*/

SELECT
    GETDATE() AS capture_time,
    ag.name AS ag_name,
    ar.replica_server_name,
    ars.role_desc,
    DB_NAME(drs.database_id) AS database_name,
    drs.synchronization_state_desc,
    drs.synchronization_health_desc,
    drs.database_state_desc,
    drs.log_send_queue_size AS log_send_queue_kb,
    drs.log_send_rate AS log_send_rate_kb_sec,
    CASE
        WHEN drs.log_send_rate > 0
        THEN CAST(drs.log_send_queue_size / NULLIF(drs.log_send_rate,0) AS decimal(18,2))
        ELSE NULL
    END AS estimated_log_send_delay_sec,
    drs.redo_queue_size AS redo_queue_kb,
    drs.redo_rate AS redo_rate_kb_sec,
    CASE
        WHEN drs.redo_rate > 0
        THEN CAST(drs.redo_queue_size / NULLIF(drs.redo_rate,0) AS decimal(18,2))
        ELSE NULL
    END AS estimated_redo_delay_sec,
    drs.last_commit_time,
    drs.last_hardened_time,
    drs.last_redone_time
FROM sys.dm_hadr_database_replica_states drs
JOIN sys.availability_replicas ar
    ON drs.replica_id = ar.replica_id
JOIN sys.dm_hadr_availability_replica_states ars
    ON drs.replica_id = ars.replica_id
JOIN sys.availability_groups ag
    ON ar.group_id = ag.group_id
ORDER BY database_name, ar.replica_server_name;
