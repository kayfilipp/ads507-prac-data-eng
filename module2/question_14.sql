/*Which users attend events together most frequently?*/

--assumption 1: in order to attend an event, a user must buy a ticket.
--assumption 2: in order to attend an event together, two users must buy a ticket with the same event id.

with attendants as (
select 
	distinct sales.eventid
	,sales.buyerid as user1
	,sales2.buyerid as user2
from 
	tickit.sales sales 
    inner join tickit.sales sales2 on 
    	sales2.eventid = sales.eventid
        and sales2.buyerid != sales.buyerid
),
coattendants as(
select 
	user1
    ,user2
    ,COUNT(eventid) as co_attended
    ,RANK() OVER (ORDER BY COUNT(eventid) desc) as rank
from 
	attendants
group by
	user1,user2
)
select user1,user2,co_attended from coattendants where rank = 1;  