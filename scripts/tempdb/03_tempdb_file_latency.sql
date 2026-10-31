/*
Purpose:
Check TempDB read/write latency.
*/

SELECT
    DB_NAME(vfs.database_id) AS database_name,
    mf.name AS file_name,
    mf.type_desc,
    vfs.num_of_reads,
    vfs.num_of_writes,
    CAST(vfs.io_stall_read_ms / NULLIF(vfs.num_of_reads, 0) AS decimal(18,2)) AS avg_read_ms,
    CAST(vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes, 0) AS decimal(18,2)) AS avg_write_ms,
    mf.physical_name
FROM sys.dm_io_virtual_file_stats(DB_ID(N'tempdb'), NULL) vfs
JOIN tempdb.sys.database_files mf
    ON vfs.file_id = mf.file_id
ORDER BY avg_write_ms DESC, avg_read_ms DESC;
