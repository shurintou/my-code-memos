--the MERGE statement can be used as an alternative method for updating data in a table with those in another table.

MERGE INTO
    tableA AS targetTable 
USING
    (SELECT columnA, columnB FROM tableB) AS sourceTable   
ON 
    targetTable.id= sourceTable.id 
WHEN MATCHED THEN
    UPDATE SET 
        targetTable.columnA = sourceTable.columnA,
        targetTable.columnB = sourceTable.columnB