/*
Purpose:
Find cached queries with the most logical reads.
High logical reads often drive CPU and buffer pool churn.
*/

SELECT TOP (50)
    DB_NAME(st.dbid) AS database_name,
    OBJECT_NAME(st.objectid, st.dbid) AS object_name,
    qs.execution_count,
    qs.total_logical_reads,
    CAST(qs.total_worker_time / 1000000.0 AS decimal(18,2)) AS total_cpu_sec,
    SUBSTRING
    (
        st.text,
        (qs.statement_start_offset / 2) + 1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset
          END - qs.statement_start_offset) / 2) + 1
    ) AS sql_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY qs.total_logical_reads DESC;
