
-- Imaging we have table named 'LESSONS' with data like this.
--lesson_id	lesson_date	lesson_startTime	
--    1	    2020-01-01	 16:00:00.0000000	
--    2	    2020-01-01	 17:00:00.0000000	
--    3	    2020-01-01	 18:00:00.0000000	
--    4	    2020-01-01	 19:00:00.0000000	
--    5	    2020-01-01	 20:00:00.0000000	
--    6	    2020-01-01	 21:00:00.0000000	
--    7	    2020-01-02	 16:00:00.0000000	
--    8	    2020-01-02	 17:00:00.0000000	
--    9	    2020-01-02	 18:00:00.0000000	
--    10    2020-01-02	 19:00:00.0000000	
--    11    2020-01-02	 20:00:00.0000000	
--    12    2020-01-02	 21:00:00.0000000	
--    13    2020-01-03	 16:00:00.0000000	
--    14    2020-01-03	 17:00:00.0000000	
--    15    2020-01-03	 18:00:00.0000000	
--    16    2020-01-03	 19:00:00.0000000	
--    17    2020-01-03	 20:00:00.0000000	
--    18    2020-01-03	 21:00:00.0000000	
--    19    2020-01-04	 16:00:00.0000000	
--    20    2020-01-04	 17:00:00.0000000	
--    21    2020-01-04	 18:00:00.0000000	
--    22    2020-01-04	 19:00:00.0000000	
--    23    2020-01-04	 20:00:00.0000000	
--    24    2020-01-04	 21:00:00.0000000	
--    25    2020-01-05	 16:00:00.0000000	
--    26    2020-01-05	 17:00:00.0000000	
--    27    2020-01-05	 18:00:00.0000000	
--    28    2020-01-05	 19:00:00.0000000	
--    29    2020-01-05	 20:00:00.0000000	
--    30    2020-01-05	 21:00:00.0000000	
--    31    2020-01-06	 16:00:00.0000000	
--    32    2020-01-06	 17:00:00.0000000	
--    33    2020-01-06	 18:00:00.0000000	
--    34    2020-01-06	 19:00:00.0000000	
--    35    2020-01-06	 20:00:00.0000000	
--    36    2020-01-06	 21:00:00.0000000	
--    37    2020-01-07	 16:00:00.0000000	
--    38    2020-01-07	 17:00:00.0000000	
--    39    2020-01-07	 18:00:00.0000000	
--    40    2020-01-07	 19:00:00.0000000	
--    41    2020-01-07	 20:00:00.0000000	
--    42    2020-01-07	 21:00:00.0000000	
--    43    2020-01-08	 16:00:00.0000000	
--    44    2020-01-08	 17:00:00.0000000	
--    45    2020-01-08	 18:00:00.0000000	
--    46    2020-01-08	 19:00:00.0000000	
--    47    2020-01-08	 20:00:00.0000000	
--    48    2020-01-08	 21:00:00.0000000	
--    49    2020-01-09	 16:00:00.0000000	
--    50    2020-01-09	 17:00:00.0000000	
--    51    2020-01-09	 18:00:00.0000000	
--    52    2020-01-09	 19:00:00.0000000	
--    53    2020-01-09	 20:00:00.0000000	
--    54    2020-01-09	 21:00:00.0000000	
-- now we want to update 'lesson_startTime' to '17:00:00' at the first three of the each lesson_date partition.
-- and the sql would be like this.
UPDATE
    LESSONS
SET
    lesson_startTime = '17:00:00'
WHERE
    lesson_id IN (
        SELECT T2.lesson_id
        FROM
        (
            SELECT 
                T1.lesson_id, 
                ROW_NUMBER() OVER(PARTITION BY lesson_date ORDER BY lesson_startTime) AS row_num   -- the sequence of the record in its partition
            FROM 
                LESSONS T1
        ) AS T2
        WHERE row_num <=3 -- the first three of the each lesson_date partition
    )


-- then we want to select random one recode from each lesson_date partition.
-- and the sql would be like this.
SELECT
    T2.lesson_id
FROM
    (
        SELECT 
            T1.lesson_id, 
            ROW_NUMBER() OVER(PARTITION BY lesson_date ORDER BY NEWID()) AS row_num  -- order records by NEWID() would be random.
        FROM 
            LESSONS T1
    ) AS T2
WHERE
    row_num = 1