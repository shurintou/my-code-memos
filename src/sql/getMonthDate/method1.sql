-- SQL SERVER 2017(RTM) - 14.0.1000.169
-- This is a sql that get the full set of dates in an certain month (ex. 2020.12.1 ~ 2020.12.31)
-- Using a Stored procedure
SELECT
    DATEADD(DAY, n, number, DATEFROMPARTS(2020,12,1)) AS date_value
FROM
    master..spt_values n
WHERE
    n.type = 'p'
    AND
    n.number <= DATEDIFF(DAY, DATEFROMPARTS(2020,12,1), EOMONTH(DATEFROMPARTS(2020,12,1)))