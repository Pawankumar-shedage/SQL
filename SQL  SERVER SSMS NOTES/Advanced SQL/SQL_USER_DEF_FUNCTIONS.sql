

--SQL USER DEFINED FUNCTIONS (UDF)

use  [SQL TUTORIAL]

select * from
[SQL TUTORIAL].dbo.EMPLOYEES

--write a udf to return employees with given age
--SCALAR FUNCTION
ALTER FUNCTION  dbo.GetEmpNameByAge(@Age integer)
returns varchar(100) as
begin
	declare @EmpName varchar(100);
	
	SELECT @EmpName = EmpName
	FROM EMPLOYEES
	WHERE Age = @Age
	
	return @EmpName

END

SELECT	[SQL TUTORIAL].dbo.GetEmpNameByAge(35) As CalAge
FROM EMPLOYEES
-----------------------------------------------------------------------------

--2 Inline Table-Valued Functons	(iTVF)
	--returns table that are similar to views but accept parameters

--Return all the [gender] employees.
ALTER FUNCTION GetEmployeesByGender(@Gender varchar(10))
RETURNS TABLE AS
RETURN(
	SELECT * from 
	EMPLOYEES
	where Gender = @Gender
)


SELECT * FROM	[SQL TUTORIAL].dbo.GetEmployeesByGender('Female') 



--3 Multivalue Statement Table-Valued Functions (mTVF)

--Create a Multi-Statement Table-Valued Function to Return Employees by Age Range:
--Write a multi-statement table-valued function that takes two parameters, @MinAge and @MaxAge, and returns all employees whose ages fall within this range.

CREATE FUNCTION GetEmpByAgeRange(@MinAge integer, @MaxAge integer)
returns table
as 
RETURN(
	SELECT * 
	FROM EMPLOYEES
	WHERE Age BETWEEN @MinAge AND @MaxAge
)

SELECT * FROM [SQL TUTORIAL].dbo.GetEmpByAgeRange(25,35)    --Here we are selecting from a result table.


select * from GetEmpByAgeRange(24,34)


-----------------------------------------------


select *
from sys.tables

--combined tables employees + employee_salaries.
CREATE TABLE EmpDetails (
EmpID int PRIMARY KEY,
EmpName varchar(100),
Age int,
Gender varchar(10),
Role varchar(50),
Salary varchar(100)
)


INSERT INTO EmpDetails(EmpID,EmpName,Age,Gender,Role,Salary) 
SELECT	
	e.Emp_ID,e.EmpName,e.Age,e.Gender,s.emp_role,s.salary
FROM 
	 EMPLOYEES e
JOIN 
	EMPLOYEES_SALARIES s
ON  e.Emp_ID = s.emp_id


select * from EmpDetails

------------------------------------------------------------------------------------
--Question: Salary hike based on  role


SELECT * FROM EmpDetails

ALTER FUNCTION GiveSalaryHike(@EmpRole varchar(100),@Hike float)
returns @UpdatedSalaries TABLE
(
 EmpID int,
 EmpName varchar(100),
 Age int,
 Gender varchar(10),
 Salary decimal(10,2)
)
AS
BEGIN
	INSERT INTO @UpdatedSalaries		
	SELECT EmpID,EmpName,Age,Gender, Salary*(1+@Hike/100)
	FROM EmpDetails
	WHERE  Role = @EmpRole

	Return
END

SELECT * from GiveSalaryHike('Salesman',5.3)



------------------------------------------------------------------------------------
USE [SQL TUTORIAL]

SELECT * FROM EmpDetails

select name
from sys.tables
