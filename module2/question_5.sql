/*Find the event with the highest amount of sales for each city.*/
--we combine a CTE with a RANK window to get our answer.

WITH event_sales AS(
SELECT
	venue.venuecity
    ,event.eventname
    ,SUM(sales.pricepaid) as amountofsales
  	,RANK() over (PARTITION BY venue.venuecity order by SUM(sales.pricepaid) desc) as rank
FROM
	sample_data_dev.tickit.venue venue 
    INNER JOIN tickit.event event on event.venueid = venue.venueid 
    INNER JOIN tickit.sales sales on sales.eventid = event.eventid 
GROUP BY 
	venue.venuecity,event.eventname
) 
SELECT
	venuecity
    ,eventname
    ,amountofsales
FROM event_sales 
WHERE rank = 1;