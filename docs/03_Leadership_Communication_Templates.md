# Leadership Communication Templates

## CPU Pressure Identified

Current evidence indicates CPU scheduler pressure. SQL workers are ready to run but waiting for CPU time, shown by elevated runnable task queues and SOS_SCHEDULER_YIELD waits. Memory, TempDB, and AG synchronization are being validated separately to avoid misattribution.

## CPU Scaling Validated

Post-upgrade validation confirms SQL Server recognizes the additional vCPUs and scheduler pressure has materially improved. Runnable queues dropped from elevated levels to healthier levels, indicating the resize directly addressed CPU scheduler saturation.

## Memory Concern Response

Current evidence does not indicate memory starvation. SQL Server is expected to use available memory for buffer cache. We do not see pending memory grants, RESOURCE_SEMAPHORE pressure, or low-memory indicators. Current concern is workload/query behavior rather than memory capacity.

## AG Health Response

Always On synchronization is healthy. Databases are synchronized, log send queues and redo queues are minimal, and estimated redo delay is effectively zero. Current evidence does not support AG lag as a cause of slowness.

## Blocking Identified

Current slowness appears related to a localized blocking chain rather than infrastructure saturation. We have identified the head blocker and are reviewing the SQL text, transaction age, lock object, and application source.

## Query Hotspot Identified

The issue is workload-specific. A stored procedure is consuming excessive CPU/logical reads and large memory grants. Infrastructure appears stable; the next step is execution plan review, indexing/statistics validation, and query shape optimization.
