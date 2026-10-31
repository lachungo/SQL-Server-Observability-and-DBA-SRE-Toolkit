/*
Purpose:
Show which databases own the buffer pool cache.
*/

SELECT
    DB_NAME(database_id) AS database_name,
    COUNT(*) * 8 / 1024 AS cached_mb
FROM sys.dm_os_buffer_descriptors
WHERE database_id <> 32767
GROUP BY database_id
ORDER BY cached_mb DESC;
