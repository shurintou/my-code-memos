-- SQL SERVER 2017(RTM) - 14.0.1000.169
-- This is a sql that get the full set of dates in an certain month (ex. 2020.12.1 ~ 2020.12.31)
-- Using a with expressoin
WITH DATE_TABLE(DATE_VALUE) AS(
    SELECT
        DATEFROMPARTS(2020,12,1)
    UNION ALL
    SELECT
        DATEADD(dd,1,DATE_VALUE)
    FROM
        DATE_TABLE
    WHERE
        DATE_VALUE < EOMONTH(DATEFROMPARTS(2020,12,1))
)

SELECT
    DATE_VALUE AS month_date,
    CASE
        WHEN DATEPART(WEEKDAY,DATE_VALUE) > 1
    THEN
        DATEPART(WEEKDAY,DATE_VALUE) - 1
    ELSE
        7
    END AS weekday_code -- Assumeing that week begins from monday with weekday_code 1
FROM
    DATE_TABLE