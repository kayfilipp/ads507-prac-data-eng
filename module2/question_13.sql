--What were the most expensive tickets sold?
--solution: rank by price per ticket, pick anything with rank = 1.

with ticket_prices as (
select distinct 
	listing.listid
	,listing.priceperticket
  	,sales.eventid
  	,CAST(sales.saletime as DATE) as saletime
  	,sales.buyerid
  	,sales.sellerid
	,RANK() OVER (ORDER BY listing.priceperticket desc) as rank
from 
	tickit.listing listing
    inner join tickit.sales sales on sales.listid = listing.listid
)
select * from ticket_prices where rank = 1;
