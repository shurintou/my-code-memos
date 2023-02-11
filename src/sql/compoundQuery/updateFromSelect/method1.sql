-- tableA and B have a relationship through the id column, 
-- we want to update tableA with values from relatived columns in table B

UPDATE 
    targetTable
SET 
    targetTable.columnA = sourceTable.columnA, 
    targetTable.columnB = sourceTable.columnB
FROM 
    tableA targetTable
INNER JOIN -- If LEFT JOIN is used, a null will be updated while INNER JOIN always update with value.
    tableB sourceTable
ON 
    targetTable.id = sourceTable.id
WHERE
    1 = 1 --conditions if necessary