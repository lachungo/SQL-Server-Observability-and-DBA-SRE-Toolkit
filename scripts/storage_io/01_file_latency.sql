/*
Purpose:
Show average file read/write latency.
*/

SELECT
    DB_NAME(vfs.database_id) AS database_name,
    mf.name AS file_name,
    mf.type_desc,
    CAST(vfs.io_stall_read_ms / NULLIF(vfs.num_of_reads,0) AS decimal(18,2)) AS avg_read_ms,
    CAST(vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes,0) AS decimal(18,2)) AS avg_write_ms,
    vfs.num_of_reads,
    vfs.num_of_writes,
    mf.physical_name
FROM sys.dm_io_virtual_file_stats(NULL,NULL) vfs
JOIN sys.master_files mf
    ON vfs.database_id = mf.database_id
   AND vfs.file_id = mf.file_id
ORDER BY avg_read_ms DESC, avg_write_ms DESC;
