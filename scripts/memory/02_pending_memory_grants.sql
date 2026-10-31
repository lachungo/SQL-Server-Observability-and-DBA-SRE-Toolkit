/*
Purpose:
Identify queries waiting for memory grants.
Expected healthy result: zero rows.
*/

SELECT *
FROM sys.dm_exec_query_memory_grants
WHERE grant_time IS NULL;
