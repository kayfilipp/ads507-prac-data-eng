/*What days were outliers for the number of ticket sales?*/

--we can answer this question by aggregating the number of total sales by calendar date and then joining to the date table.
--we can define an outlier as a distance of +2 standard deviations from the mean for simplicity.
DROP TABLE IF EXISTS aggsales;
DROP TABLE IF EXISTS metrics;

--1. aggregate ticket sales by calendar date
SELECT 
	date.caldate		as caldate
    ,SUM(sales.qtysold) as totalsales
INTO temp TABLE aggsales
FROM 
	tickit.sales sales
    INNER JOIN tickit.date date on date.dateid = sales.dateid
GROUP BY 
	date.caldate;
   
--2. create a table called metrics that contains the average sales and std. dev thereof.
SELECT
	AVG(totalsales) as mu
    ,STDDEV_SAMP(totalsales) as sd
INTO temp TABLE metrics
FROM aggsales;
   
--3. return calendar days that satisfy the condition of 25% or less than the mean
SELECT
	caldate
    ,totalsales
    ,(totalsales * 1.0)/(metrics.mu) as percent_of_mean
FROM
	aggsales
    CROSS JOIN metrics
WHERE
	percent_of_mean < 0.25