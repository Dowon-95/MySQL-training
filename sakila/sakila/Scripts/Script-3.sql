
select 1 num, 'abc' str
union
select 2 num, 'xyz' str;

select 1 num, 'abc' str
union
select 1 num, 'abc' str; /*중복 제거*/

select 1 num, 'abc' str
union all
select 1 num, 'abc' str; /*중복 제거안함*/

desc customer ;
desc actor ;

/*798rows*/
select 'customer' typ, first_name, last_name   from customer c  /*599*/
union
select 'actor' typ, first_name, last_name   from actor a ; /*200*/

/*799rows*/
select 'customer' typ, first_name, last_name   from customer c  /*599*/
union all
select 'actor' typ, first_name, last_name   from actor a ; /*200*/

/*교집합*/
select c.first_name , c.last_name 
  from customer c 
 where c.first_name like 'J%' and c.last_name like 'D%'
intersect
select a.first_name , a.last_name 
  from actor a 
 where a.first_name like 'J%' and a.last_name like 'D%';

/*차집합*/
select c.first_name , c.last_name 
  from customer c 
 where c.first_name like 'J%' and c.last_name like 'D%'
except
select a.first_name , a.last_name 
  from actor a 
 where a.first_name like 'J%' and a.last_name like 'D%';



