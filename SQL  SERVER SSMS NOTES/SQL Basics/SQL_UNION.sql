
--UNIONS - 
		--The UNION operator is used to combine the result-set of two or more SELECT statements.

		--Every SELECT statement within UNION must have the same number of columns
		--The columns must also have similar data types
		--The columns in every SELECT statement must also be in the same order

use [SQL TUTORIAL]


--[1]Write a query to list all employee roles and genders in a single column using UNION.
select emp_role AS value
from EMPLOYEES_SALARIES
union 
select gender AS value
from employees

--[2]Write a query to list all employee roles and genders in a single column using UNION ALL, and include duplicates.
select emp_role AS value
from EMPLOYEES_SALARIES
union all
select gender AS value
from employees

select * from EMPLOYEES
select * from employees_salaries

--**imp
--[3]Write a query to list the names of all employees who are either over 30 years old or have a salary greater than 50,000, using UNION.

	--using join as we have age col in 'EMPLOYEES' table and 'Salary' col in 'EMPLOYEES_SALARIES' table.
select a.EmpName AS employees_over_30_or_having_salary_more_than_50K
from EMPLOYEES a join EMPLOYEES_SALARIES b on a.Emp_ID = b.emp_id
union 
select a.EmpName 
from EMPLOYEES a join EMPLOYEES_SALARIES b on a.Emp_ID = b.emp_id
where a.Age > 30 OR b.salary > 50000
order by a.EmpName

--[4] Write a query to find distinct employees who are either "Salesmen" or have a salary less than 45,000, using UNION.
use [SQL TUTORIAL]

SELECT A.EmpName,B.emp_role,B.salary
from employees  A
JOIN EMPLOYEES_SALARIES B 
	ON A.Emp_ID = B.emp_id
where b.emp_role = 'Salesman'
UNION 
SELECT A.EmpName,B.emp_role,B.salary
froM EMPLOYEES A JOIN EMPLOYEES_SALARIES B on A.Emp_ID = B.emp_id
where  b.salary < 45000


--[5]Write a query to list all distinct employees who are either "Accountants" or "Salesmen" using UNION.

SELECT A.emp_name
from employees  A
JOIN EMPLOYEES_SALARIES B on A.Emp_ID = B.emp_id
where b.emp_role = 'Accountants'

UNION 

SELECT A.emp_name
froM EMPLOYEES A JOIN EMPLOYEES_SALARIES B on A.Emp_ID = B.emp_id
where b.emp_role = 'Salesman'


--**** UNION|UNION ALL| INTERSECT| EXCEPT****

--QUESTIONS
--1. UNION and UNION ALL

--Question 1: Retrieve a list of all distinct product_id values from 
--both the Prices and UnitsSold tables.		(Unique Products)

select product_id
from Prices
UNION 
Select product_id
FROM UnitsSold

--2. INTERSECT
--Question 4: Retrieve the list of product_id values 
--that are present in both the Prices and UnitsSold tables.	(Common)


select product_id
from PRICES
INTERSECT 
Select product_id
FROM Products


--3.EXCEPT
--Retrieve product_id values
--that are in the Prices table but not in the UnitsSold table.
--(get the prod which is not sold)

SELECT product_id
from PRICES
EXCEPT
SELECT product_id
from UnitsSold

select * from PRICES
select * from UnitsSold

--4. Combining Set Operations
--Question 8: Use a combination of UNION, INTERSECT, and EXCEPT 
--to retrieve product_id values that are only in the Prices table 
--but also exist in another table (e.g., Products) and do not exist in the UnitsSold table.

SELECT product_id FROM (
	SELECT product_id from Prices
	INTERSECT 
	SELECT product_id from Products 
)AS CommonProducts
EXCEPT 
SELECT product_id
from UnitsSold

