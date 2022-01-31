/*Find the number of unique buyers per day.*/

--accomplish this with the DISTINCT function over the buyerid.
SELECT
	date.caldate as day
    ,COUNT(DISTINCT sales.buyerid) as unique_buyers
    ,COUNT(sales.buyerid) as buyers
    ,(buyers*1.0)/unique_buyers as sales_per_buyer
FROM
	tickit.sales sales 
    INNER JOIN tickit.date date on date.dateid = sales.dateid 
GROUP BY 
	date.caldate
ORDER BY
	sales_per_buyer desc