-- These are some useful sql in sql server.

-- Check the version of your sql server
SELECT @@version


-- Get the id of an certain DB
SELECT DB_ID(N'you database name') AS [Database ID]


-- Check the locks of an certain DB
SELECT
    resource_type,
    resource_associated_entity_id,
    request_status,
    request_mode,
    request_session_id,
    resource_description
FROM
    sys.dm_tran_locks
WHERE
    resource_database_id = 0 -- 0 is the id of your DB


-- Check the info of a certain connection, such as isolation level
DBCC USEROPTIONS


-- Check the connection of a certain DB
sp_who -- or sp_who2


-- Set the isolation level of a certain connection
--  READ UNCOMMITTED
--  READ COMMITTED
--  REPEATABLE READ
--  SNAPSHOT
--  SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


-- Set the READ_COMMITED_SNAPSHOT ON/OFF
ALTER DATABASE 
    you_db 
SET
    READ_COMMITTED_SNAPSHOT ON -- or OFF
-- If you wait too long to set this, add the expression below would be work, 
-- but before you do that, make sure you do know what you are doing.
--WITH
    --ROLLBACK IMMEDIATE

-- When SET XACT_ABORT is ON, if a Transact-SQL statement raises a run-time error, the entire transaction is terminated and rolled back.
SET XACT_ABORT ON
-- Execute a sql with transaction
BEGIN TRANSACTION
    SELECT 
        *
    FROM
        YOUR_TABLE
    WITH
        (ROWLOCK, XLOCK, READPAST) -- Table hints if necessary
    WHERE
        id = 0
WAITFOR DELAY '00:00:05' -- You may want to check the lock so to make some delay would be a choice
COMMIT TRANSACTION
