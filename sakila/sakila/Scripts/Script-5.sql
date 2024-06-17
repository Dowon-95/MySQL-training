

desc customer ;

select customer_id, first_name,last_name 
from customer c
where customer_id in ( select max(customer_id) from customer c2  );


select customer_id 
  from customer c 
  limit 1;
 
 select max(customer_id) from customer c; 

desc city;
desc country ;

select * from city;

select city_id, city 
  from city ct
 inner join country c on ct.country_id = c.country_id 
 where c.country not in ('INDIA');

select city_id , city
  from city c 
 where country_id <> ( select country_id from country c2 where c2.country = 'INDIA');

desc customer; 
 
select customer_id 
  from customer c 
 where 20 = (
			select count(*) 
			  from rental r 
			 where r.customer_id = c.customer_id 
 		);

select first_name , last_name 
  from customer c 
 where ( 
		select sum(amount)
		  from payment p 
		 where c.customer_id  = p.customer_id
 		) between 180 and 240;

 	
select c.customer_id , first_name ,last_name 
  from customer c 
 where exists (
 		select r.customer_id
 		  from rental r 
 		 where r.customer_id = c.customer_id 
 		   and date(rental_date) < '20050525'
 		);
   

 	
desc actor ;

select a.first_name , a.last_name 
  from actor a 
 where not exists (
 				select 1
 				  from  film_actor fa
 				 inner join film f on f.film_id = fa.film_id
 				  where a.actor_id = fa.actor_id
 				    and f.rating = 'R'
 				);
  
 
 			
desc customer ;

select c.first_name ,c.last_name , payInfo.rental_cnt, payInfo.payments_tot
  from customer c
 inner join (
 			select customer_id , count(*)as rental_cnt, sum(amount)as payments_tot 
 			  from payment p
 			 group by customer_id 
 			)as payInfo
 		on c.customer_id = payInfo.customer_id;
  
  
  
  
 select 1, 'ABC'
 union 
select 2, 'DEF';
  
  
 
select 'small' as name  , 0 as low_limit, 74.99as high_limit
union all
select 'average' as name, 75 as low_limit, 149.99 as high_limit
union all
select 'heavy' as name, 150 as low_limit, 999999.99 as high_limit;
  

select payGroupInfo.name, count(*) num_cus 
  from (
  		select customer_id , count(*)as rental_cnt, sum(amount)as payments_tot 
  		  from payment p 
  		 group by customer_id
  		)as payInfo /*고객정보 + 결제정보*/
  inner join
  (
  	select 'small' as name , 0 as low_limit, 74.99as high_limit
	union all
	select 'average' as name, 75 as low_limit, 149.99 as high_limit
	union all
	select 'heavy' as name, 150 as low_limit, 999999.99 as high_limit			
  )payGroupInfo /*결제 분류 논리 테이블*/
    on payInfo.payments_tot between low_limit and high_limit
   group by payGroupInfo.name;
  
  
 with actors_s as
 	( select actor_id, first_name, last_name
 	    from actor a 
 	   where last_name like 'S%'
 	),
	actors_s_pg as 
	( select s.actor_id, s.first_name, s.last_name, 
			 f.film_id
	    from actors_s s
	   inner join film_actor fa on s.actor_id = fa.actor_id
	   inner join film f on fa.film_id = f.film_id
	   where f.rating = 'PG'
	),
	actors_s_pg_income as 
	( select spg.first_name, spg.last_name, p.amount
		from actors_s_pg spg
	   inner join inventory i on spg.film_id = i.film_id
	   inner join rental r on i.inventory_id = r.inventory_id
	   inner join payment p on r.rental_id = p.rental_id
	)
	select spg_income.first_name, spg_income.last_name, sum(spg_income.amount)as tot_revenue
	  from actors_s_pg_income as spg_income
	 group by spg_income.first_name, spg_income.last_name
	 order by 3 desc ;
	

/* 영화 배우를 조회. 영화 배우 ID, 영화 배우명(first_name, last_name) 
 * 
 * 단, 정렬 조건은 영화 배우가 출연한 영화수로 내림차순 정렬이 되도록 하고,
 * 정렬 조건을 Sub Query로 작성할 것.
 * */
 
	select * from actor a;
	
  select a.actor_id, a.first_name ,a.last_name 
    from actor a
    inner join (
    			select actor_id, count(*)as act_cnt 
    			  from film_actor fa inner join film f  on fa.film_id = f.film_id
    			 group by actor_id 
    			)as film_act
     on a.actor_id = film_act.actor_id
    order by film_act.act_cnt desc ;
   
 
  * 대여 가능한 DVD 영화 리스트를 조회.
 * film id, 제목, 재고수 가 조회도록 SQL 작성. 
 *	rental 의 return_date = null 이 아닌 경우를 세면 => 재고수 
 *
 * 단, 모든 영화가 빠짐없이 조회가 되도록 해야 함.
 * */
 
 
 with rent as
	 (select inventory_id 
	    from rental r 
	   where return_date is not null
	 ),
	 rent_inv as
	 ( select f.film_id, f.title, rnt.inventory_id
	     from rent as rnt
	     inner join inventory i on rnt.inventory_id = i.inventory_id
	     inner join film f on i.film_id = f.film_id
	 )
select inv.film_id , inv.title , count(inv.inventory_id)as inv_cnt
  from rent_inv as inv 
  group by inv.film_id , inv.title;

 
 /* 0 ~ 399 */    
SELECT ones.num + tens.num + hundreds.num
 FROM
 (SELECT 0 num UNION ALL
 SELECT 1 num UNION ALL
 SELECT 2 num UNION ALL
 SELECT 3 num UNION ALL
 SELECT 4 num UNION ALL
 SELECT 5 num UNION ALL
 SELECT 6 num UNION ALL
 SELECT 7 num UNION ALL
 SELECT 8 num UNION ALL
 SELECT 9 num) ones
 CROSS JOIN
 (SELECT 0 num UNION ALL
 SELECT 10 num UNION ALL
 SELECT 20 num UNION ALL
 SELECT 30 num UNION ALL
 SELECT 40 num UNION ALL
 SELECT 50 num UNION ALL
 SELECT 60 num UNION ALL
 SELECT 70 num UNION ALL
 SELECT 80 num UNION ALL
 SELECT 90 num) tens
 CROSS JOIN
 (SELECT 0 num UNION ALL
 SELECT 100 num UNION ALL
 SELECT 200 num UNION ALL
 SELECT 300 num) hundreds
order by 1;
    
  
with one_day as
	(SELECT ones.num + tens.num + hundreds.num as numb
	 FROM
	 (SELECT 0 num UNION ALL
	 SELECT 1 num UNION ALL
	 SELECT 2 num UNION ALL
	 SELECT 3 num UNION ALL
	 SELECT 4 num UNION ALL
	 SELECT 5 num UNION ALL
	 SELECT 6 num UNION ALL
	 SELECT 7 num UNION ALL
	 SELECT 8 num UNION ALL
	 SELECT 9 num) ones
	 CROSS JOIN
	 (SELECT 0 num UNION ALL
	 SELECT 10 num UNION ALL
	 SELECT 20 num UNION ALL
	 SELECT 30 num UNION ALL
	 SELECT 40 num UNION ALL
	 SELECT 50 num UNION ALL
	 SELECT 60 num UNION ALL
	 SELECT 70 num UNION ALL
	 SELECT 80 num UNION ALL
	 SELECT 90 num) tens
	 CROSS JOIN
	 (SELECT 0 num UNION ALL
	 SELECT 100 num UNION ALL
	 SELECT 200 num UNION ALL
	 SELECT 300 num) hundreds
	order by 1
	),
	calendar as 
	(
	select date_add('2005-01-01', interval od.numb Day)as dat
		from one_day as od
	   where od.numb < 365
	)
	select rental_date , count(*)as rent_cnt 
	  from calendar as cal
	 inner join rental r on cal.dat = r.rental_date 
	group by rental_date; 


