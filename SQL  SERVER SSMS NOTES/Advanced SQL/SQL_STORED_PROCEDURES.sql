
--STORED PROCEDURES  (CREATE,ALTER PROCEDURES)
use [SQL TUTORIAL]

CREATE PROCEDURE GetEmployeesTBL
AS 
BEGIN
(
	SELECT *
	FROM EMPLOYEES
)
END

EXEC GetEmployeesTBL

select * from EMPLOYEES

--Varchar is used when you know you stores only English characters or Non- Unicode characters
--where as NVarchar is used where you want to store Non English characters or Unicode characters. 
--A Varchar stores maximum 8000 characters where as 
--NVarchar store maximum 4000 Unicode/Non-Unicode characters.

--[2]sp with arguments (INPUT).
CREATE PROCEDURE sp_GetNoOfPeople 
			@JobTitle nvarchar(100)
AS
(
	SELECT EMPLOYEES.Emp_ID,EmpName,Salary
	FROM EMPLOYEES 
	JOIN EMPLOYEES_SALARIES
		ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
	WHERE EMPLOYEES_SALARIES.emp_role = @JobTitle
)

EXEC sp_GetNoOfPeople @JobTitle = 'Salesman'

-----------------------------------------------------------
--ALTER SYNTAX
ALTER PROCEDURE sp_GetNoOfPeople
				@JobTitle varchar(50),
				@Age int
AS
(
	SELECT EMPLOYEES.Emp_ID,EmpName,Age,Salary
	FROM EMPLOYEES 
	JOIN EMPLOYEES_SALARIES
		ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
	WHERE EMPLOYEES_SALARIES.emp_role = @JobTitle AND Age >= @Age
)



EXEC sp_GetNoOfPeople @JobTitle = 'Salesman', @Age = 30