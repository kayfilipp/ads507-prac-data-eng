/*Find the day over day count of orders to see how the business is doing.*/

/*we can use a CTE + window function to acomplish this. we're interested in the number of distinct sales, as opposed to the number of tickets.*/
--in our deliverable we offer two new insights: the total number of orders day over day, plus the % change in orders day over day.

WITH daily_orders AS(
	SELECT
      date.caldate as day
  	  ,lag(COUNT(sales.salesid), 1) over (ORDER BY date.caldate) as prev_orders
      ,COUNT(sales.salesid) as daily_orders
  	FROM
  		tickit.sales sales 
  		INNER JOIN tickit.date date on date.dateid = sales.dateid 
	GROUP BY 
  		date.caldate
  	ORDER BY
  		date.caldate
)
SELECT
  day
  ,daily_orders
  ,SUM(daily_orders) OVER (ORDER BY day ROWS UNBOUNDED PRECEDING) as cumulative_sum
  ,ROUND(
    ((daily_orders - prev_orders)/(prev_orders*1.0)) * 100.00,
    2
   )															  as delta_day_over_day
FROM daily_orders;