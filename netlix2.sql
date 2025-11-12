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


--Business Problems


--1.Count the number of movies vs tv shows
select
	type,
	count(*) as total_content
from netlix_project1
group by type


--2. Select the most common rating for movies and TV shows
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


--3.list all the movies released in a specific year
select * from netlix_project1
where 
	type = 'Movie'
	AND
	release_year= 2020


--4. Select the top5 countries with the most content on netflix
select 
	unnest(string_to_array(country, ',')) as new_country,
	count(show_id) as total_content
from netlix_project1
Group by 1

select
	unnest(string_to_array(country, ',')) as new_country
from netlix_project1 

--5. Identify the longest movie

select * from netliX_project1
where 
	type ='Movie'
	and 
	duration=(select max(duration) from netlix_project1)


--6. Find content added in the last 5 years
select * from netlix_project1
where 
	to_Date(date_added, 'Month DD, YYYY')>= CURRENT_DATE-INTERVAL '5 years'


--7. Find all the movies directed by Rajiv Chilaka
select * from netlix_project1
where director like '%Rajiv Chilaka%'


--8. List all the TV shows with 5 or more seasons
select * from netlix_project1
where 
	type = 'TV Show'
	duration > 5 seasons

--9.Count the number of content items in  each genre 
select 
	unnest(string_to_array(listed_in, ',')) as genre,
	count(show_id) as total_content
from netlix_project1
group by 1

--10.Find each year and the average numbers of content release in India on netlix.

total content 333/972

select 
	extract(year from to_date(date_added, 'Month DD, YYYY')) as year,
	count(*) as yearly_content,
	round(
	count(*)::numeric/(select count(*) from netlix_project1 where country= 'India')::numeric * 100
	,2)as avg_content_per_year
from netlix_project1
where country='India'
group by 1

--11. List all movies that are documentaries

select * from netlix_project1
where
	listed_in like '%Documentaries%'


--12. Find all content without a director
select * from netlix_project1
where 
	director is NULL

--13.Find out how many movies in which salman khan has appeared in last 10 years
select * from netlix_project1
where
	casts ILIKE '%Salman Khan%'
	and 
	release_year > Extract(year from current_date) - 10


