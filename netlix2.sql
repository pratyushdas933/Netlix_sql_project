create table netlix_project1 
(
	show_id varchar(20),
	type varchar(25),
	title VARCHAR(140),
	director VARCHAR(250),
	casts VARCHAR(800),
	country	VARCHAR(150),
	date_added varchar(50),
	release_year int,
	rating varchar(50),
	duration varchar(50),
	listed_in VARCHAR(120),
	description VARCHAR (300)
)

select distinct type from netlix_project1;

select
	type,
	count(*) as total_content
from netlix_project1
group by type

select 
	type,
	rating
from 
(	select
		type,
		rating,
		count(*),
		rank() over (partition by type order by count(*) DESC) as ranking
	from netlix_project1
	group by 1,2
) as t1
where 
	ranking = 1

select * from netlix_project1
where 
	type = 'Movie'
	AND
	release_year= 2020

select 
	unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netlix_project1
Group by 1

select
	unnest(string_to_array(country, ',')) as new_country
from netlix_project1 

select * from netliX_project1
where 
	type ='Movie'
	and 
	duration=(select max(duration) from netlix_project1)

select * from netlix_project1
where 
	to_Date(date_added, 'Month DD, YYYY')>= CURRENT_DATE-INTERVAL '5 years'


select * from netlix_project1
where director like '%Rajiv Chilaka%'

select * from netlix_project1
where 
	type = 'TV Show'
	duration > 5 seasons

select 
	unnest(string_to_array(country, ''))as new_country,
	count(show_id) as total_content
from netlix_project1
group by 1
order by 2 desc
limit 5

select * from netlix_project1
where 
	date_added= current_date-interval '5 years'

select current_date - interval '5 years'