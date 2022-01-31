/*
Find the count of sales per venue city.
*/

--1. join the venue table to the event table, join the event table to the sales table.
select 
	venue.venuecity,
    COUNT(sales.salesid) as countofsales
from 
	tickit.venue venue 
    inner join tickit.event event on event.venueid = venue.venueid 
    inner join tickit.sales sales on sales.eventid = event.eventid
group by 
	venue.venuecity
order by countofsales desc