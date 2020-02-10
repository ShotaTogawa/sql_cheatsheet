# MySQL cheatsheet

### 1. How to create database.

```sql
-- Create a database
CREATE DATABASE 'your_db_name';
ex) CREATE DATABASE pet;

-- Check your databases
SHOW DATABASES;

-- Specify a database you use.
USE 'your_db_name';
ex) USE pet;

-- Check current a used database. If not used any database, it becomes null
SELECT database();

-- Delete database. Make sure all data stored will be deleted.
DROP DATABASE <your_db_name>;
ex) DROP DATABASE pet;

```

If you run `DROP DATABASE pet;` above, please remake pet database because I am going to use this database to show queries.

### 2. Basic data types

1. Numeric Types

   - INT: A whole number(with a max value of 4294967295)
   - DECIMAL(total number of digits, digits after decimal)
     - ex) decimal(5,3) 999.99
   - FLOAT
     - memory needed: 4 Bytes
     - Precision issues: ~7 digits
   - DOUBLE
     - memory needed: 8 bytes
     - Precision issues: ~15 digits

2. String Types

   - VARCHAR: A variable-length string(between 1 and 255 chars)
     - varchar changes length depending on data.
   - CHAR: Fixed length
     |Value|Char(4)|Storege|VARCHAR(4)|Storage|
     |---|---|---|---|---|
     |''|' '|4 bytes|''|1 bytes|
     |'ab'|'ab '|4 bytes|'ab'|3 bytes|
     |'abcd'|'abcd'|4 bytes|'abcd'|5 bytes|
     |'abcdefg'|'abcd'|4 bytes|'abcdefg'|5 bytes|

3. DATE, TIME, DATETIME, TIMESTAMP
   - DATE - values with a date but not time 'YYYY-MM-DD'
   - TIME - values with a time but no date 'HH:MM:SS'
   - DATETIME - values with a date and time 'YYYY-MM-DD HH:MM:SS'
   - TIMESTAMP
     - Timestamp has date and time, but a range of timestamp is '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC.
     - TIMESTAMP also takes up less space.
     - TIMESTAMP is used for things like meta-data about when something is created or updated.

```sql
CURDATE() -- gives a current date
CURTIME() -- gives a current time
NOW() -- gives a current date time
current_timestamp -- gives a current date time

-- Date format
SELECT DATE_FORMAT(now(), '%W') -- Monday
SELECT DATE_FORMAT(now(), '%m/%d/%Y') -- 02/09/2020
SELECT DATE_FORMAT(now(), '%m/%d/%Y at %h:%m:%s') -- 02/09/2020 at 10:02:48

-- Date Math
SELECT DATEDIFF(now() , '1992-01-12'); -- 10249
SELECT now() + INTERVAL 1 MONTH; -- 2020-03-03 10:43:01
SELECT now() - INTERVAL 1 MONTH; -- 2020-01-03 10:43:34
```

### 3. How to make tables

```sql
-- Create table
-- Table name should prural
CREATE TABLE <table_name> (
    column_name1 data_type
    column_name2 data_type
);

-- Please run

-- Check tables you made
SHOW tables;

-- Delete table
DROP table <table_name>;

```

Please look at `tables.sql` and run 3-1/3-2/3-3. Please run `SHOW tables`. You should be able to see tables list including `tests`, `owners`, `pets`.

### 4. Insert data

Once you make tables, you can store data in tables.

```sql
-- Insert syntax
-- Order is matter.
INSERT INTO <table_name> (column_1, column_2)
VALUES ('Something', 10);

-- multiple insert
INSERT INTO <table_name> (column_1, column_2)
VALUES ('Something1', 10)
	  ,('Something2', 10)
	  ,('Something3', 10)
```

Please run 4-1/4-2/4-3/4-4 of `data.sql` file.

### 5. SELECT DATA

Let's see the data in tables.

```sql
-- get all data
SELECT * FROM <table_name>;

-- ex)
SELECT * FROM tests;
SELECT * FROM owners;
SELECT * FROM pets;

-- get specific columns
SELECT <column_name>, <column_name> FROM <table_name>;

-- ex)
SELECT name, created_at FROM owners
SELECT id, name FROM pets;

-- Add condition to a query
SELECT * FROM pets WHERE sex = 'F';
SELECT * FROM pets WHERE owner_id = 2;


-- aliases
SELECT owner_id as owner, name from pets;
-- it's gonna be ailias if you omit as keyword
SELECT owner_id owner from pets;


```

### 6. Update

```sql
-- Update specific data
UPDATE <table_name> set <column_name> = 'something';
where <column_name> = 'something';

-- ex)
SELECT * FROM owners where id = 3; -- check previous records
UPDATE owners SET name = 'Coffee' WHERE id = 3;
SELECT * FROM owners where id = 3; -- check current records


-- Update data of the columns to set data
UPDATE <table_name> set <column_name> = 'something';

-- ex)

SELECT * FROM tests; -- check previous records
UPDATE tests set test = 'Updated';
SELECT * FROM tests; -- check current records
```

### 7. DELETE record

```sql
-- DELETE specific record
SELECT * FROM owners where id = 4; -- check previous records
DELETE FROM owners where id = 4;
SELECT * FROM owners where id = 4; -- check current records

-- DELETE every records
SELECT * FROM tests; -- check previous records
DELETE FROM tests;
SELECT * FROM tests; -- check current records
```

### 8. String fuction

Order is matter when you use some string functions together because the number of arguments are different depending on the function.

```sql
-- Concat (combine strigns)
-- ex)
SELECT concat('Hello', ' ', 'World');

-- CONCAT_WS
-- maybe useful when you want to make CSV file etc...
SELECT concat_ws( ',' ,'Hello', 'World'); -- Hello,World

-- substring / substr
SELECT substring(<column>, <first_position>, <end_position>) from <table>;
-- ex)
SELECT substring('Hello World', 1, 3); --Hel
SELECT substring('Hello World', 7); --World

-- substr + concat
insert into tests (test) values ('It is a long established fact that a reader will be distracted by the readable');

SELECT
	concat(
		substr(test, 1, 100),
		'...'
	)
from tests;

-- replace
SELECT replace(<target_value>, <from_value>, <to_value>) from <table>;
-- ex)
SELECT replace('Hello World', 'Hello', 'Hi,'); -- Hi World

-- reverse
SELECT reverse('Hello World') as reverse; -- dlroW olleH

-- char_length
-- space is counted
SELECT char_length('Hello World') as length; -- 11


-- UPPER() and LOWER()
SELECT upper('Hello World') as uppercase; -- HELLO WORLD
SELECT lower('HEllo World') as lowercase; -- hello world
```

### 9. DISTINCT/ ORDER BY/ LIMIT/ LIKE

```sql
-- DISTINCT
-- remove duplicated data

-- ex)
INSERT INTO tests (test) VALUES ('test');
INSERT INTO tests (test) VALUES ('test');
INSERT INTO tests (test) VALUES ('test');

SELECT * FROM tests; -- check data in tests table.
SELECT DISTINCT test FROM tests;
SELECT DISTINCT test FROM tests; -- check the result.

-- ORDER BY
-- Sorting
-- ascending by default

SELECT * FROM <table> ORDER BY <column> asc -- ascending order by <column>
-- ex)
SELECT * FROM owners ORDER BY id;

SELECT * FROM <table> ORDER BY <column> desc -- decending order by <column>
-- ex)
SELECT * FROM owners ORDER BY id desc;


 -- ascending order by <column2>
SELECT <column1>, <column2>, <column3> FROM <table> order by 2;

-- ex)
SELECT id, name, owner_id as owner FROM pets ORDER BY 3 desc;


-- order by column1 first. If there are same data in column1, then data is sorted by coloumn2
SELECT * FROM <table> ORDER BY <column1>, <column2> asc;

-- ex)
SELECT id, name, owner_id as owner FROM pets ORDER BY owner, name desc;




-- LIMIT
-- Pagination
SELECT * FROM <table> LIMIT 4; -- get 4 data FROM top

-- ex)
SELECT * FROM owners LIMIT 2;


-- LIKE
-- search
-- include 't' in the data
SELECT * FROM pets where name LIKE '%t%';
-- start with 'c'
SELECT * FROM pets where name LIKE 'c%';
-- end with 'A'
SELECT * FROM pets where name LIKE '%A';
-- return data included 't' 2times
SELECT * FROM pets where name like '%t%t%';
-- _ any single character
SELECT name FROM owners where name LIKE '______'; -- in this case, return 6 character's data
```

### 10. Group BY/ Aggregate Function

"GROUP BY" summarizes or aggregates identical data into single rows

```sql
SELECT <column>, count(*) FROM <table> GROUP BY <column>;

-- ex)
SELECT owner_id as owner, count(*)
FROM pets
GROUP BY owner_id;

-- count
select count(*) from tests;
select test, count(*) from tests group by test;

-- MIN and MAX
select min(id) from owners; -- return a minimum number
select max(id) from owners; -- return a maximum number

-- subquery
-- First, a query in where clause is run, then the result become condition of main query.
select * from pets where owner_id = (select min(id) from owners);

-- SUM
CREATE TABLE items (name varchar(50), price int, category varchar(50));
insert into items (name, price, category) values ('apple', 3, 'fruit');
insert into items (name, price, category) values ('chocolate', 5, 'snack');
insert into items (name, price, category) values ('beef steak', 18,'meat');
insert into items (name, price, category) values ('orange', 5, 'fruit');
insert into items (name, price, category) values ('chips', 8, 'snack');
insert into items (name, price, category) values ('pork', 11, 'meat');


select sum(price) from items;

-- AVG(average)
select avg(price) from items;

```

### 11. Logical Operator

```sql
-- Not Equal (!=)
select * from pets where owner_id != 1;

-- Not Like (NOT LIKE)
SELECT * FROM pets where name NOT LIKE 'c%'; -- data doesn't start with c'

-- Greater than (>)
-- Greater than equal (>=)
select * from items where price > 5; -- not included 5
select * from items where price >= 5; -- include 5

select 10 > 1; -- return 1 (true)
select 1 > 10; -- return 0 (false)
select 'a' > 'b'; -- return 0
select 'A' > 'a'; -- return 0

-- Less than (<)
-- Less than equal (<=)
select * from items where price < 5;
select * from items where price <= 5;

-- Logical AND(&&)
-- BOTH sides must be true
select * from pets where owner_id = 1 and sex = 'M';
select * from pets where owner_id = 1 && sex = 'M';

-- Logical OR(||)
-- Only one side must be true
select * from pets where owner_id = 2 OR sex = 'F';
select * from pets where owner_id = 2 || sex = 'F';

-- between
-- combination greater than and less than
select * from items where price between 5 and 8;
select * from items where price not between 5 and 8;


-- IN and NOT IN
select * from items where category in ('snack', 'meat');
select * from items where category not in ('snack', 'meat');

-- CASE
select
	name,
	category,
	case
		when price <= 5 then "0 - $5"
		when price <= 10 then "$6 - $10"
		else '$10 -'
	END as price_range
from
	items
order by price_range desc

select
	name,
	category,
	case
		when price between 0 and 5 then "0 - $5"
		when price between 6 and 10 then "$6 - $10"
		else '$10 -'
	END as price_range
from
	items
order by price_range desc
```

### Relation ...continue
