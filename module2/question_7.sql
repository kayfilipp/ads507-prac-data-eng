--What percentage of listed tickets did each event sell?

/*
in this approach, we use two CTEs that aggregate the total listed and total sold tickets for each event and join them together.
this also counters the edge case where events had no sales but did list tickets.
*/
WITH 
listed_tickets AS 
(
	SELECT
  		listing.eventid
  		,SUM(listing.numtickets) as total_listed
	FROM
  		tickit.listing listing
  		GROUP BY listing.eventid
),
sold_tickets AS
(
	SELECT
  		sales.eventid
  		,SUM(sales.qtysold) as total_sold
  	FROM tickit.sales sales
  	GROUP BY sales.eventid
)

SELECT
	sold.eventid
    ,sold.total_sold
    ,listed.total_listed
    ,ROUND(sold.total_sold/(listed.total_listed*1.0),2) * 100.00 as percent_sold
FROM 
	sold_tickets sold
    INNER JOIN listed_tickets listed on listed.eventid = sold.eventid
ORDER BY percent_sold desc;