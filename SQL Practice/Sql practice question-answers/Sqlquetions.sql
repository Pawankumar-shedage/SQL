

--QUESTIONS FOR PRACTICE IN SQL For EMPLOYEES TABLE

--Basic Retrieval and Filtering:

--Write a query to retrieve all employees who are older than 30 years.

SELECT * 
FROM EMPLOYEES
WHERE Age > 30

--Write a query to find employees whose name starts with 'P'.
SELECT * 
FROM EMPLOYEES
WHERE EmpName LIKE 'P%'

--Aggregations:

--Write a query to find the average age of employees grouped by gender.
SELECT Gender,AVG(Age) As AvgAge
FROM EMPLOYEES
GROUP BY Gender


--Write a query to count the number of employees in each age group (20-30, 31-40, etc.).

SELECT 
	CASE 
		WHEN AGE BETWEEN 20 AND 30 THEN '20-30'
		WHEN AGE BETWEEN 31 AND 40 THEN '31-40'
	ELSE 'OTHER'
	END AS AgeGroup,
	COUNT(*) AS AgeCount
FROM EMPLOYEES
GROUP BY 
	CASE
		WHEN AGE BETWEEN 20 AND 30 THEN '20-30'
		WHEN AGE BETWEEN 31 AND 40 THEN '31-40'
	ELSE 'OTHER'
	end;


--Subqueries:

--Write a query to find the youngest employee.
SELECT * FROM EMPLOYEES 
WHERE Age = (SELECT MIN(age) FROM EMPLOYEES) 

--Write a query to list employees who are younger than the average age.
SELECT * FROM EMPLOYEES 
WHERE Age < (SELECT AVG(age) FROM EMPLOYEES) 


--Window Functions:

--Write a query to calculate the cumulative(Running total) count of employees grouped by gender and ordered by empID.
SELECT *, COUNT(*) over (partition by gender order by Emp_ID) as CummulativeCount
from EMPLOYEES

--Write a query to rank employees by age within each gender.
SELECT *, RANK() over (partition by gender order by age desc ) as Rank
from EMPLOYEES

select COUNT(*)
from EMPLOYEES

--Common Table Expressions (CTEs):

--Write a CTE to find the average age of employees and then list employees who are older than this average age.
WITH AvgAgeCTE AS (
    SELECT AVG(Age) AS AvgAge FROM EMPLOYEES
)
SELECT * FROM 
EMPLOYEES,AvgAgeCTE
where Age > AvgAgeCTE.AvgAge


--Write a recursive CTE to generate a sequence of numbers from 1 to 10.
with printNumbersTill as 
(
	select 1 as Numbers
	union all
	select Numbers+1
	from printNumbersTill
	where Numbers<10
)
select * from printNumbersTill

--User-Defined Functions:

--Create a scalar function that takes an employee's empID and returns their name.
ALTER FUNCTION GetEmpNameByID(@EmpID integer)
Returns varchar(100)
as
begin
	
	declare @EmpName varchar(100)

	SELECT @EmpName=EmpName
	FROM EMPLOYEES
	WHERE Emp_ID = @EmpID
	
	RETURN @EmpName
END

SELECT  [SQL TUTORIAL].dbo.GetEmpNameByID(1004) as EmpWithID


--Create a table-valued function that returns all employees of a specified gender.
ALTER FUNCTION GetEmployeesByGender(@Gender varchar(10))
RETURNS TABLE AS
RETURN(
	SELECT * from 
	EMPLOYEES
	where Gender = @Gender
)


SELECT * FROM	[SQL TUTORIAL].dbo.GetEmployeesByGender('Female') 


--Stored Procedures:

--Create a stored procedure that updates an employee's age based on their empID.
--Create a stored procedure that retrieves employees who meet a minimum age criteria.

--Triggers:

--Create a trigger that logs changes to an employee's age into a separate audit table whenever their age is updated.
--Create a trigger that prevents any updates to the empID field.

--Advanced Joins and Set Operations:

--Write a query to find the intersection of employees who have the same name but different empID.
--Write a query using a full outer join to combine the EMPLOYEES table with another table containing department details.

--Dynamic SQL:

--Write a dynamic SQL query to retrieve employee details based on different conditions provided as input parameters.