--What commission structure does the TICKET website follow?
--Although it seems that every transaction follows a 15% structure, we use the distinct operator to be defensive about edge cases.
select distinct (1.0 * commission) / pricepaid as percentage_paid from tickit.sales;