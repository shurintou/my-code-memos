--to insert new record in your table if not exists
INSERT INTO
    MYTABLE(id,columnA,columnB)
SELECT
    newRowId,value1,value2
WHERE NOT EXISTS
    (
        SELECT 
            1 
        FROM
            MYTABLE
        WHERE
            id = newRowId
    )