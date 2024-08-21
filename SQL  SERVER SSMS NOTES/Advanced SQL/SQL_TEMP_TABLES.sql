--#Temp Tables -
	--SESSEION BASED tables
	--USed for Storing temp data, and perform operations on them.
USE [SQL TUTORIAL]

SELECT NAME
FROM sys.tables

DROP TABLE  IF EXISTS #TEMP_TABLE1

CREATE TABLE #TEMP_TABLE2(
	JobTitle varchar(50),
	EmployeesPerJob int,
	AvgAge int,
	AvgSalary int
)

INSERT INTO #TEMP_TABLE2
SELECT emp_role,Count(emp_role),AVG(Age), AVG(salary)
FROM [SQL TUTORIAL]..EMPLOYEES
JOIN [SQL TUTORIAL]..EMPLOYEES_SALARIES
	ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
GROUP BY emp_role

SELECT * 
FROM #TEMP_TABLE2


