/*Find all the users who have bought a ticket to a musical and also like sports.*/

--two criteria here: (1) the USER must have been the BUYER in the sale of a ticket to an EVENT with a CATEGORY name of sports.
-- (2) the USER likes sports. (this condition requires us to only inspect the user table.)
select distinct
	users.userid
    ,users.firstname
    ,users.lastname
from
	tickit.event event 
    inner join tickit.category category on category.catid = event.catid 
    inner join tickit.sales sales on sales.eventid = event.eventid
    inner join tickit.users users on users.userid = sales.buyerid 
where
	category.catname = 'Musicals'
    and users.likesports = true;