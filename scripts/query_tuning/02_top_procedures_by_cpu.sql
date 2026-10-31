/*
Purpose:
Find stored procedures consuming the most CPU.
*/

SELECT TOP (50)
    DB_NAME(database_id) AS database_name,
    OBJECT_NAME(object_id, database_id) AS procedure_name,
    execution_count,
    CAST(total_worker_time / 1000000.0 AS decimal(18,2)) AS total_cpu_sec,
    CAST((total_worker_time / NULLIF(execution_count,0)) / 1000.0 AS decimal(18,2)) AS avg_cpu_ms,
    CAST(max_worker_time / 1000.0 AS decimal(18,2)) AS max_cpu_ms,
    total_logical_reads,
    CAST(total_elapsed_time / 1000000.0 AS decimal(18,2)) AS total_elapsed_sec,
    last_execution_time
FROM sys.dm_exec_procedure_stats
ORDER BY total_worker_time DESC;
