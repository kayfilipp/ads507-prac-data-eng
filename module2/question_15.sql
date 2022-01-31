/*How common is it for users to buy tickets to events outside of their state?*/
--we can define this in two steps:
--find the total number of ticket purchases where the event state =/= user state
--divide this by the total number of ticket purchases.

with purchases as (
select 
	users.userid
  	,sales.salesid
    ,users.state as userstate
    ,venue.venuestate
    ,cast(users.state <> venue.venuestate as integer) as out_of_state_purchase
from 
    tickit.users users 
  	inner join tickit.sales sales on users.userid = sales.buyerid
    inner join tickit.event event on event.eventid = sales.eventid
    inner join tickit.venue venue on venue.venueid = event.venueid
)
select ROUND(SUM(out_of_state_purchase)/(COUNT(out_of_state_purchase)*1.0),3) as percentage_out_of_state from purchases;