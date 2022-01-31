/*In command line: sqlite3 "PATH NAME TO DB/mod2_db.db" */

drop table if exists users;
create table users(
	userid integer not null primary key,
	username char(8),
	firstname varchar(30),
	lastname varchar(30),
	city varchar(30),
	state char(2),
	email varchar(100),
	phone char(14),
	likesports boolean,
	liketheatre boolean,
	likeconcerts boolean,
	likejazz boolean,
	likeclassical boolean,
	likeopera boolean,
	likerock boolean,
	likevegas boolean,
	likebroadway boolean,
	likemusicals boolean);
create index users_index on users(userid);

/* format users */
UPDATE users SET likesports = CASE WHEN likesports = 't' THEN 1 ELSE 0 END;
UPDATE users SET liketheatre  = CASE WHEN liketheatre  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likeconcerts  = CASE WHEN likeconcerts  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likejazz  = CASE WHEN likejazz  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likeclassical  = CASE WHEN likeclassical  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likeopera  = CASE WHEN likeopera  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likerock  = CASE WHEN likerock  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likevegas  = CASE WHEN likevegas  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likebroadway  = CASE WHEN likebroadway  = 't' THEN 1 ELSE 0 END;
UPDATE users SET likemusicals = CASE WHEN likemusicals = 't' THEN 1 ELSE 0 END;

drop table if exists venue;
create table venue(
	venueid smallint not null primary key,
	venuename varchar(100),
	venuecity varchar(30),
	venuestate char(2),
	venueseats integer);
create index venue_index on venue(venueid);

drop table if exists category;
create table category(
	catid smallint not null primary key,
	catgroup varchar(10),
	catname varchar(10),
	catdesc varchar(50));
create index cat_index on category(catid); 

drop table if exists date;
create table date(
	dateid smallint not null primary key,
	caldate date not null,
	day character(3) not null,
	week smallint not null,
	month character(5) not null,
	qtr character(5) not null,
	year smallint not null,
	holiday boolean default('N'));
create index date_index on date(dateid);
/*because we imported as csv, we dont need to mess with the caldate.*/
UPDATE date SET holiday = CASE WHEN holiday = 't' THEN 1 ELSE 0 END;
 
drop table if exists event;
create table event(
	eventid integer not null primary key,
	venueid smallint not null,
	catid smallint not null,
	dateid smallint not null,
	eventname varchar(200),
	starttime timestamp);
create index event_index on event(eventid);

drop table if exists listing;
create table listing(
	listid integer not null primary key,
	sellerid integer not null,
	eventid integer not null,
	dateid smallint not null,
	numtickets smallint not null,
	priceperticket decimal(8,2),
	totalprice decimal(8,2),
	listtime timestamp);
create index listing_index on listing(listid);

drop table if exists sales;
create table sales(
	salesid integer not null primary key,
	listid integer not null,
	sellerid integer not null,
	buyerid integer not null,
	eventid integer not null,
	dateid smallint not null,
	qtysold smallint not null,
	pricepaid decimal(8,2),
	commission decimal(8,2),
	saletime timestamp);
create index sales_index on sales(salesid);

