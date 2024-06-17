
select rental_date 
  from rental
 where date(rental_date) = '20050524';

select rental_date 
  from rental r 
 where date(rental_date) <> '20050524';
 
select rental_date 
  from rental
 where date(rental_date) between '20050614' and '20050616';
 
select * from payment p ;

select customer_id ,payment_date ,amount 
  from payment p 
 where amount between 10.0 and 11.0;

select title ,rating 
  from film f 
 where rating in ('G','PG');

select title ,rating 
  from film f 
 where title like '%PET%';

select title ,rating 
  from film f 
 where rating in ( select rating 
  					 from film
  					where title like '%PET%'
 					);

 select last_name, left(last_name, 1)
  from customer
 where left(last_name, 1) = 'Q';

select *
  from rental
 where return_date is null;


/* self join 실습 용 table 및 데이터 
 */

CREATE TABLE EMP
       (EMPNO int NOT NULL,
        ENAME VARCHAR(10),
        JOB VARCHAR(9),
        MGR int,
        HIREDATE DATE,
        SAL int,
        COMM int,
        DEPTNO int);

INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        date('1980-12-17'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        '1981-02-20', 1600,  300, 30);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        '1982-01-23', 1300, NULL, 10);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        '1981-02-22', 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        '1981-04-02',  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        '1981-09-28', 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        '1981-05-01',  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        '1981-06-09',  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        '1982-12-09', 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        '1981-09-08',  1500, NULL, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        '1983-01-12', 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        '1981-12-03',   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        '1981-12-03',  3000, NULL, 20);
        
select count(*) from emp; /* rows : 14 */

select count(*) from customer;/*599*/ 
select count(*) from address;/*603*/

select customer_cnt.cnt , address_cnt.cnt, cartesian_cnt.cnt
  from 
  	(select count(*)as cnt from customer)as customer_cnt,
  	(select count(*)as cnt from address)as address_cnt,
  	(select count(*)as cnt 
  	  from customer c
  	  join address a)as cartesian_cnt;
  	 
 
 select count(*)
   from customer c join address a on c.address_id =a.address_id ;

desc address ;

select c.first_name , c.last_name , a.address 
  from customer c join address a on c.address_id = a.address_id 
 where a.postal_code = 52137;

/* 3테이블 조인. customer, city, address */

desc customer ;
desc address;
desc city ;

/* 1. 표준 SQL 사용해서 3 테이블 관계 */

select c.first_name , c.last_name , ct.city /*count(*)*/
  from customer c 
  inner join address a on c.address_id = a.address_id 
  inner join city ct on a.city_id = ct.city_id ;
 
/* 2. 서브 쿼리를 활용. 큰틀에서는 테이블 2개로 맺는것 처럼. */
 
select c.first_name, c.last_name, addr.city 
  from customer c 
 left join(
 				select a.address_id, a.address, ct.city
 				  from address a inner join city ct on a.city_id = ct.city_id
 			)as addr
 	on c.address_id = addr.address_id;
 
 /* 3. 2번에서 서브쿼리로 사용한 sql 을 view 롤 생성. 서브쿼리 대신 view를 사용한 sql로 작성 */

 create view addr_vw as
 select a.address_id, a.address, ct.city
   from address a inner join city ct on a.city_id = ct.city_id;

select * from addr_vw ;

select c.first_name ,c.last_name ,addr.city
  from customer c 
 inner join addr_vw as addr
    on c.address_id  = addr.address_id;
   
select count(*)
  from customer c 
 inner join addr_vw as addr
    on c.address_id  = addr.address_id;



