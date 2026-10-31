/*
Purpose:
Review SQL Server memory configuration and OS memory state.
*/

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'max server memory (MB)';
EXEC sp_configure 'min server memory (MB)';

SELECT
    total_physical_memory_kb / 1024 / 1024 AS total_physical_memory_gb,
    available_physical_memory_kb / 1024 / 1024 AS available_physical_memory_gb,
    system_memory_state_desc
FROM sys.dm_os_sys_memory;

SELECT
    physical_memory_in_use_kb / 1024 / 1024 AS sql_memory_in_use_gb,
    locked_page_allocations_kb / 1024 / 1024 AS locked_pages_gb,
    process_physical_memory_low,
    process_virtual_memory_low
FROM sys.dm_os_process_memory;
