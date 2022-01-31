/*Write a query to determine whether there are any resellers in the dataset.*/

/*we can define a reseller as an individual who bought tickets and then sold them again.
a user is a reseller if they:
	(a) bought a ticket from some event X (buyerid = userid in sales table)
	(b) sold a ticket from some event X after buying it (sellerid = userid in sales table and saletime_sell > saletime_buy)
*/

--step 1: get all listings for which a user has sold a ticket at an event 
--if they have sold a ticket, join all ticket sales for which the user has been a buyer.
WITH transactions AS(
  select
      sales.eventid
  	  ,sales.qtysold
      ,sales.saletime
      ,sales.sellerid
      ,sales.buyerid
  from
	  tickit.sales sales
)
/*
	the following query retrieves all dates of sale of tickets for an event FOLLOWING a ticket purchase made by a user.
    since we're only interested in the presence of a user in this table, we can trim it down with the distinct operator.
    we self-join the transactions table, treating trans1 as the history of ticket purchases and trans2 as the history of ticket sales for a user.
*/
select
	distinct trans1.buyerid,
	--SUM(qtysold) as total_sold
from
	transactions trans1
    INNER JOIN transactions trans2 on 
    	trans2.sellerid = trans1.buyerid
        and trans2.saletime > trans1.saletime
        and trans2.eventid = trans1.eventid