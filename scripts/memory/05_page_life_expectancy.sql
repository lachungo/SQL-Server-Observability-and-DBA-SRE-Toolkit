/*
Purpose:
Show Page Life Expectancy.
Interpret with context. PLE alone is not enough.
*/

SELECT
    object_name,
    counter_name,
    instance_name,
    cntr_value AS PLE_seconds
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Page life expectancy';
