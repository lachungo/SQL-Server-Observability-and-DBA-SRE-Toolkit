/*
Purpose:
Validate TempDB file count, size, and growth.
*/

USE tempdb;
GO

SELECT
    name,
    type_desc,
    size * 8 / 1024 AS size_mb,
    CASE WHEN is_percent_growth = 1 THEN NULL ELSE growth * 8 / 1024 END AS growth_mb,
    is_percent_growth,
    physical_name
FROM sys.database_files
ORDER BY type_desc, name;
