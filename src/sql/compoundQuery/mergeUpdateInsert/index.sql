

MERGE INTO 
    tableA AS targetTable
USING 
    (
        SELECT id, columnA, columnB
        FROM tableB
    ) AS sourceTable
ON 
    (targetTable.id = sourceTable.id)
WHEN MATCHED THEN
    UPDATE SET
        targetTable.columnA = sourceTable.columnA, 
        targetTable.columnB = sourceTable.columnB
WHEN NOT MATCHED THEN
    INSERT
        (id, columnA, columnB)
    VALUES
        (sourceTable.id, sourceTable.columnA, sourceTable.columnB)


-- statement below could be an alternative
WHEN NOT MATCHED BY TARGET THEN -- record that not in target table would be inserted into target table
    INSERT
        (id, columnA, columnB)
    VALUES
        (sourceTable.id, sourceTable.columnA, sourceTable.columnB)
WHEN NOT MATCHED BY SOURCE THEN -- record that not in source table would be deleted from target table
    DELETE;