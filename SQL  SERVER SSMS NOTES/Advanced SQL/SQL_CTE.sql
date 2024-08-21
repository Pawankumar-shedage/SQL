--ADV SQL CTE- COMMON TABLE EXPRESSIONS.

SELECT * FROM EMPLOYEES_SALARIES


WITH CTE_Employee AS
	(SELECT EmpName,Age,Gender,salary,
	Count(Gender) OVER (PARTITION BY gender) As TotalGender,
	Avg(salary) OVER (PARTITION BY gender) As AvgSalary
	FROM EMPLOYEES
	JOIN EMPLOYEES_SALARIES
		ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
	WHERE salary > 40000
)
SELECT * FROM CTE_Employee


SELECT * FROM [SQL TUTORIAL].dbo.EMPLOYEES

--QUESTIONS

--[1]Write a CTE to select all employees who are older than 30 from the EMPLOYEES table.
	WITH CTE_SenoirEmployees AS (
		 SELECT Emp.Emp_ID, Emp.EmpName, Emp.Age, Emp.Gender
		 FROM [SQL TUTORIAL].dbo.EMPLOYEES AS Emp
		 WHERE Emp.Age > 30
	)
	SELECT * FROM CTE_SenoirEmployees

--[2]Write a CTE to generate a sequence of numbers from 1 to 10. Print numbers from 1 to 10;
	WITH Numbers AS(
		 SELECT 1 AS num
		 UNION ALL
		 SELECT num+1
		 FROM Numbers
		 WHERE num < 10
	)
	SELECT * FROM Numbers;


--[3]Write a query using multiple CTEs to first find the total number of male and female employees, 
	--and then select only the gender with the higher count.
	WITH GenderCounts As(
		SELECT Gender, COUNT(*) As Count
		FROM EMPLOYEES
		Group by Gender
	),
	MaxGender AS(
		SELECT Gender
		FROM GenderCounts
		WHERE Count = (SELECT MAX(Count) FROM GenderCounts)
	)
	SELECT * FROM MaxGender


--[5]Write a CTE to create a temporary result set with employee names and ages, 
   --and then join it with another table (e.g., DEPARTMENTS table with empID and Department columns) to get the department of each employee.
	WITH EmployeeDetails AS (
		SELECT Emp.Emp_ID, Emp.EmpName,Emp.Age,Emp.Gender,SAL.emp_role, SAL.salary
		FROM EMPLOYEES Emp
		JOIN EMPLOYEES_SALARIES SAL
			ON Emp.Emp_ID = SAL.emp_id
	)
	SELECT Emp_ID, EmpName, salary FROM EmployeeDetails

	USE [SQL TUTORIAL]
--INTERMEDIATE - (Nested CTE's)
-- [6] Filtering OUT (removing) employees whose age is less than AVERAGE age of their gender!
	WITH AvgAgeByGender AS(
		SELECT gender, AVG(Age) AS AvgAge
		FROM EMPLOYEES
		Group by gender
	),
	EmployeesAboveAvgAge AS(
		SELECT Emp.Emp_ID, Emp.EmpName, Emp.Age,Emp.Gender, AG.AvgAge
		FROM EMPLOYEES Emp
		JOIN AvgAgeByGender AG ON Emp.Gender = AG.gender
		WHERE Emp.Age >= AG.AvgAge
	)
	SELECT * FROM EmployeesAboveAvgAge
	--avg age for female - 29, Male - 34


	--[Generic] Query for filtering employees whose age is Greater than avg age of all employees
	--(The query will return all employees whose age is greater than or equal to the average age of all employees)
	WITH AvgAge AS (
		SELECT AVG(age) AS AvgAge
		FROM EMPLOYEES
	)
	SELECT * FROM EMPLOYEeS,AvgAge
	WHERE Age  >= AvgAge.AvgAge

----------------------------------------------------

--AGE RANGES
--[7] Write a CTE to transform the EMPLOYEES table to display age ranges (e.g., 20-30, 31-40) 
--and the count of employees in each range.
	
	WITH AgeRanges AS(
	SELECT 
		CASE
			WHEN Age BETWEEN 20 and 30 THEN '20-30'
			WHEN Age BETWEEN 31 and 40 THEN '31-40'
			ELSE '40+'
		END AS AgeRange,
	COUNT(*) As Count_Of_Employees
	FROM EMPLOYEES
	GROUP BY CASE	
				WHEN Age BETWEEN 20 and 30 THEN '20-30'
				WHEN Age BETWEEN 31 and 40 THEN '31-40'
				ELSE '40+'
			 END
	)
	SELECT * FROM AgeRanges


--[8]Write a CTE to find the top 3 oldest employees in the EMPLOYEES table.
	
	WITH TopOldestEmployees AS (
		SELECT Emp_ID,EmpName,Age,Gender,
			ROW_NUMBER() OVER (ORDER BY age DESC) as RowNum
		FROM EMPLOYEES
	)
	SELECT Emp_ID, EmpName, Age, Gender
	FROM TopOldestEmployees
	WHERE RowNum <=3


--DATA CLEANUP, to research..
--[9] Clean duplicate entries based on Emp_ID in EMPLOYEES TABLE.
	
--BEGIN TRANSACTION;

	WITH CTE_RemoveDuplicates AS (
		SELECT *,
			ROW_NUMBER() OVER (PARTITION BY Emp_ID order by Emp_ID) AS RowNum
		FROM EMPLOYEES
	)
	DELETE FROM EMPLOYEES
	WHERE Emp_ID IN (
		SELECT Emp_ID 
		FROM CTE_RemoveDuplicates
		WHERE RowNum > 1
	)

--ROLLBACK TRANSACTION;
	

-------------MISC-------(Useful check, alter statemets..)
	--insert into EMPLOYEES values
	--(1014,'Lola',43,'Male')

	--select * from employees
	--order by Emp_ID

	--Check for DUPS
	SELECT Emp_ID, COUNT(*)
	FROM EMPLOYEES
	GROUP BY Emp_ID
	HAVING COUNT(*) > 1;

	-- Check for NULL values
	SELECT *
	FROM EMPLOYEES
	WHERE Emp_ID IS NULL;


--BEGIN TRANSACTION

--	ALTER TABLE EMPLOYEES
--	ADD PRIMARY KEY (Emp_ID);

--ROLLBACK TRANSACTION

--to get table description
EXEC sp_help 'EMPLOYEES'
--to get primary keys in table
EXEC sp_pkeys 'EMPLOYEES'

SELECT COLUMN_NAME, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'EMPLOYEES' AND COLUMN_NAME = 'Emp_ID';

--ALTER TABLE EMPLOYEES
--ALTER COLUMN Emp_ID varchar(50) NOT NULL ;