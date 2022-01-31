/*How long do buyers wait between sales to buy more tickets?*/
--we can answer this by getting the average number of days between ticket sales for each buyer,
--and then average the total waiting period across all users.


/*to understand this problem, a window function is required on a per-user basis that gets the sale date and the previous date.*/
WITH wait_times AS(
SELECT
	sales.buyerid
    ,lag(sales.saletime,1) over (PARTITION BY sales.buyerid ORDER BY sales.saletime) as prev_saletime
    ,sales.saletime
    ,DATEDIFF(day,prev_saletime,sales.saletime) as wait_time
  	,ROW_NUMBER() OVER (PARTITION BY sales.buyerid ORDER BY sales.saletime) as row
FROM 
	tickit.sales sales
)
SELECT
    AVG(wait_time) average_days_between_sales
FROM
	wait_times
    