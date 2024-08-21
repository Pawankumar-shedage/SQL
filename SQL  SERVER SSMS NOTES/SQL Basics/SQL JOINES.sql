
/* JOINS in SQL , use:to retrieve data from more than one table*/ 

use [SQL TUTORIAL]

select * from employees
select * from employees_salaries


/*Inner join (default)*/

SELECT * 
FROM [SQL TUTORIAL].dbo.EMPLOYEES
Inner Join EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id;


/* FULL OUTER JOIN */

SELECT * 
FROM [SQL TUTORIAL].dbo.EMPLOYEES
FULL OUTER JOIN EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id



/*LEFT , Right */
SELECT * 
FROM [SQL TUTORIAL].dbo.EMPLOYEES
LEFT JOIN EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id

SELECT * 
FROM [SQL TUTORIAL].dbo.EMPLOYEES
RIGHT JOIN EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id


/*Misc*/


select EMPLOYEES.Emp_ID, Emp_name, Age , salary
FROM [SQL TUTORIAL].dbo.EMPLOYEES
JOIN [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id;

/*to find person with highest salary excluding a particular employee*/

select  EMPLOYEES.Emp_ID, Emp_name, salary
FROM [SQL TUTORIAL].dbo.EMPLOYEES
RIGHT JOIN [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
where  Emp_name <> 'Michael'
order by salary desc


/*[2] To find average salary of a salesman*/
SELECT emp_role , AVG(salary) as AVG_SALARY
FROM [SQL TUTORIAL].dbo.EMPLOYEES
INNER JOIN [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
where emp_role = 'salesman'
GROUP BY EMP_ROLE

-- TABLE DATA
select * from [SQL TUTORIAL].dbo.EMPLOYEES
full outer join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id;

-- Practice questions

select Emp_name, emp_role,salary
from [SQL TUTORIAL].dbo.EMPLOYEES
join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id;

--left join
select Emp_name, emp_role,salary
from [SQL TUTORIAL].dbo.EMPLOYEES
left join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id;


--[3]Join with Conditions: Retrieve the names and salaries of female employees.
select Emp_name,salary
from [SQL TUTORIAL].dbo.EMPLOYEES
left join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
where gender = 'Female'


--[4] Join with Aggregates: Retrieve the total salary for each role.

select emp_role, SUM(salary) AS TOTAL_SALARY_PER_ROLE
from [SQL TUTORIAL].dbo.EMPLOYEES
right outer join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
group by emp_role

--[5] Self Join: Assuming the Employees table has a ManagerID field that refers to the EmpID of the manager, 
--retrieve the list of employees along with their manager names and their roles and salaries from the Employee_Salaries table.
-- 

SELECT  Emp_name, emp_role,salary
from [SQL TUTORIAL].dbo.EMPLOYEES
inner join [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES
on EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
where EMPLOYEES_SALARIES.emp_role Like '%Manager%' OR EMPLOYEES_SALARIES.emp_role Like 'Manager%'


--[6] Self join on employees salaries table. : Write a query to find pairs of employees who have the same role but different salaries.
SELECT * FROM EMPLOYEES_SALARIES


SELECT A.emp_id AS EMP1, B.emp_id AS EMP2, A.emp_role AS ROLE, A.SALARY AS SALARY1, B.SALARY AS SALARY2
FROM EMPLOYEES_SALARIES A
JOIN  EMPLOYEES_SALARIES B 
ON A.emp_role = B.emp_role
WHERE A.emp_id < B.emp_id
AND A.salary <> B.salary
ORDER BY A.salary DESC, B.salary DESC


WITH EMPLOYEE_PAIRS AS (
	SELECT A.emp_id AS EMP1, B.emp_id AS EMP2, A.emp_role AS ROLE, A.SALARY AS SALARY1, B.SALARY AS SALARY2
	FROM EMPLOYEES_SALARIES A
	JOIN  EMPLOYEES_SALARIES B 
			ON A.emp_role = B.emp_role
			AND A.emp_id < B.emp_id
			AND A.salary <> B.salary
			
)
SELECT DISTINCT E.emp_ID, E.Emp_name, E.Age
FROM EMPLOYEES E
JOIN (
	select EMP1 AS Emp_ID from EMPLOYEE_PAIRS
	union
	select EMP2 AS Emp_ID from EMPLOYEE_PAIRS
)
AS ep ON E.Emp_ID = ep.Emp_ID
ORDER BY E.emp_ID;
