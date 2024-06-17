

desc rental;

select customer_id from rental r ;

select customer_id 
  from rental r 
 group by customer_id; 


select customer_id , count(*) 
  from rental r 
 group by customer_id 
 having count(*) >=40; 

desc payment ;

select max(amount) as max_amt,
	   min(amount) as min_amt,
	   avg(amount) as avg_amt,
	   count(*) as num_payments 

  from payment p;


 select customer_id ,
 		max(amount) as max_amt,
	    min(amount) as min_amt,
	    avg(amount) as avg_amt,
	    sum(amount) as tot_amt,
	    count(*) as num_payments
   from payment p 
   group by customer_id;
  
  
 select max(datediff(return_date,rental_date))
   from rental r;
  
desc actor;  
  
 select actor_id ,count(*) 
   from film_actor 
  group by actor_id ;
 
 
  
  
  
  
  
  
  
  
  