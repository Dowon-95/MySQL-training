
/*================ 쿼리 입문 ====================*/

select first_name, last_name
  from customer c
 where last_name = 'MARTINEZ';

select first_name, last_name
  from customer c 
  where c.last_name like "%Z%";
 
 select * from category c ;

select * from `language` l ;

select upper(name), name from `language` l ;

select user(), database ();

select actor_id from film_actor fa order by actor_id ;

select actor_id from film_actor fa  order by actor_id desc;

select * from customer c ;

select concat(c.first_name, ' , ' , c.last_name)
 from customer c; 


select concat(cust.last_name, ',', cust.first_name),cust.email 
from (
	select c.first_name , c.last_name , c.email 
	  from customer c 
	 where c.first_name = 'JESSIE'
) cust;

select distinct(actor_id) from film_actor fa ;

create temporary table actor_j
(
	actor_id smallint(5),
	first_name varchar(45),
	last_name varchar(45)
);

select * from  actor_j;

insert into  actor_j
select actor_id, first_name, last_name
  from actor 
  where last_name = 'J%';

create view cust_vw as
select customer_id, first_name, last_name, active
  from customer;
 
select * from cust_vw;

select * from customer c ;
select * from rental r ;

select c.first_name , c.last_name ,
	   r.rental_date , r.return_date 
  from customer c 
  		inner join rental r 
  		on c.customer_id = r.customer_id
 where c.first_name = 'MARY'
 		and date(r.rental_date) = '2005-05-25';
		







