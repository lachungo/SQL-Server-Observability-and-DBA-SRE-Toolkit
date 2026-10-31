/*
Purpose:
Show tables/objects accumulating locks.
Change database name as needed.
*/

DECLARE @DatabaseName sysname = N'ATWeb';

SELECT
    OBJECT_NAME(p.object_id, DB_ID(@DatabaseName)) AS object_name,
    tl.resource_type,
    tl.request_mode,
    tl.request_status,
    COUNT(*) AS lock_count
FROM sys.dm_tran_locks tl
LEFT JOIN sys.partitions p
    ON tl.resource_associated_entity_id = p.hobt_id
WHERE tl.resource_database_id = DB_ID(@DatabaseName)
GROUP BY
    OBJECT_NAME(p.object_id, DB_ID(@DatabaseName)),
    tl.resource_type,
    tl.request_mode,
    tl.request_status
ORDER BY lock_count DESC;
