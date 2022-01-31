/*How long did it take sold-out listings to sell out?*/

--first, we define a sold out listing as one where all the tickets have been bought.
--we can determine this by making sure that numlisted = numsold 
--we can also determine the duration of time needed to sell out
--(which is usually a few months after you finish your master's program)
--by subtracting the last sale date from the listing date. we can aggregate both with the MAX()
--operator because all the list time values are the same for a listing, and allows us to avoid using an extra CTE

WITH sold_out AS(
select 
	listing.listid
    ,MAX(listing.listtime) as listtime
    ,MAX(listing.numtickets) as numlisted
    ,SUM(sales.qtysold) as numsold
    ,MAX(sales.saletime) as lastsale
from 
	tickit.listing listing
    inner join tickit.sales sales on sales.listid = listing.listid
group by
	listing.listid
having 
	SUM(sales.qtysold) = MAX(listing.numtickets)
)
SELECT
	listid,
    DATEDIFF(day,listtime,lastsale) as days_to_sell_out
FROM
	sold_out
ORDER BY 
	days_to_sell_out desc