--How many tickets were sold on each holiday of 2008?

--*cracks knuckles*, turns on "All I want for Christmas" by Mariah Carey
--we can solve this by filtering for year:2008 and holiday:true, then aggregating by caldate.
select 
	date.caldate
    ,SUM(sales.qtysold) as ticket_sales
from 
	tickit.sales sales
    inner join tickit.date date on date.dateid = sales.dateid
where 
	date.year = 2008
	and date.holiday = true
group by
	date.caldate
order by
	date.caldate;