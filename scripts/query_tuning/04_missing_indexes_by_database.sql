/*
Purpose:
Review missing index suggestions for a database.
Warning: Do not blindly create indexes. Validate against actual execution plans.
*/

DECLARE @DatabaseName sysname = N'ATWeb';

SELECT TOP (50)
    DB_NAME(mid.database_id) AS database_name,
    OBJECT_NAME(mid.object_id, mid.database_id) AS table_name,
    migs.user_seeks,
    migs.user_scans,
    CAST(migs.avg_total_user_cost AS decimal(18,2)) AS avg_total_user_cost,
    CAST(migs.avg_user_impact AS decimal(18,2)) AS avg_user_impact,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns,
    'CREATE INDEX IX_' 
        + OBJECT_NAME(mid.object_id, mid.database_id)
        + '_TuningCandidate ON '
        + mid.statement
        + ' ('
        + ISNULL(mid.equality_columns, '')
        + CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL THEN ', ' ELSE '' END
        + ISNULL(mid.inequality_columns, '')
        + ')'
        + ISNULL(' INCLUDE (' + mid.included_columns + ')', '') AS proposed_index
FROM sys.dm_db_missing_index_group_stats migs
JOIN sys.dm_db_missing_index_groups mig
    ON migs.group_handle = mig.index_group_handle
JOIN sys.dm_db_missing_index_details mid
    ON mig.index_handle = mid.index_handle
WHERE mid.database_id = DB_ID(@DatabaseName)
ORDER BY migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans) DESC;
