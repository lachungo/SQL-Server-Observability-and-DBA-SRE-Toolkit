/*
Purpose:
Baseline SQL Server CPU, memory, and startup metadata.
*/

SELECT
    @@SERVERNAME AS server_name,
    cpu_count,
    scheduler_count,
    socket_count,
    cores_per_socket,
    numa_node_count,
    physical_memory_kb / 1024 / 1024 AS physical_memory_gb,
    sqlserver_start_time
FROM sys.dm_os_sys_info;

EXEC sp_configure 'max degree of parallelism';
EXEC sp_configure 'cost threshold for parallelism';
EXEC sp_configure 'max server memory (MB)';
