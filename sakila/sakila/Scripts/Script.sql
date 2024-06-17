
show databases;

show tables;

select * from film f ;

create table person
(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	eye_color enum('BR','BL','GR'),
	birth_date date,
	street varchar(20),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
	constraint pk_person primary key(person_id)
);

select * from sakila.person;


create table favorite_food
(
	person_id smallint unsigned,
	food varchar(20),
	constraint pk_favorite_food primary key(person_id, food),
	constraint fk_favorite_food foreign key(person_id)
	references person(person_id)
);

select * from sakila.favorite_food;

insert into person
(person_id , fname, lname, eye_color, birth_date)
values
(1, 'William','Turner','BR','1990-05-15');

select * from person;

insert into person
(person_id , fname, lname, eye_color, birth_date)
values
(2, 'Mike','Willson','BR','1980-08-15');

delete from person
 where person_id = 2;

insert into favorite_food (person_id, food)
values (2,'fruit');

select * from favorite_food ff;

drop table person;

drop table favorite_food;



