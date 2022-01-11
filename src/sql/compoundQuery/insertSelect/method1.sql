INSERT INTO 
    tableA (id, columnA, created_date)
SELECT 
    1,
    (
        SELECT 
            columnA
        FROM
            tableB
        WHERE
            1 = 1 -- conditions if necessary
    ),
    GETDATE()
WHERE 
    1 = 1 -- conditions if necessary