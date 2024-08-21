
--The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".

--The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

--HAVING CLAUSE :- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
	--SELECT column_name(s)
	--FROM table_name
	--WHERE condition
	--GROUP BY column_name(s)
	--HAVING condition		--because we can't apply condition before the records are aggregated by group by 
	--ORDER BY column_name(s);


	--[1] TO FIND EMP_ROLE HAVING AVERAGE SALARY > 40000
	use [SQL TUTORIAL]
	SELECT emp_role, AVG(salary) as AvgSalary
	from employees_salaries
	group by emp_role
	having AVG(salary) > 40000
	order by AVG(salary) desc


	--[2]To find Job title with more than 1 emp is working.
	SELECT emp_role,COUNT(emp_role)
	from EMPLOYEES_SALARIES
	GROUP BY EMP_ROLE
	HAVING COUNT(EMP_ROLE) > 1
	ORDER BY COUNT(EMP_ROLE) DESC


	--[3]Write a query to find roles where the maximum salary (Salaries) is less than 67,000.
	SELECT  emp_role, MAX(salary) AS Max_Salary
	from EMPLOYEES_SALARIES
	GROUP BY emp_role
	HAVING MAX(salary) < 67000
	ORDER BY MAX(salary) 

	--[4]Write a query to find roles where the average salary (Salaries) is between $40,000 and $50,000.
	SELECT  emp_role, AVG(salary) AS AVG_Salary
	from EMPLOYEES_SALARIES
	GROUP BY emp_role
	HAVING AVG(salary)  BETWEEN 40000 and 50000
	ORDER BY AVG(salary)

	--[5] Write a query to find roles that have more than 10 employees and where the average salary (Salaries) is less than $75,000.

	SELECT  emp_role,count(emp_role)
	FROM EMPLOYEES_SALARIES
	--WHERE emp_role != 'Salesman'
	GROUP BY emp_role
	HAVING COUNT(emp_role) > 1 AND AVG(salary) < 70000
	ORDER BY COUNT(emp_role)