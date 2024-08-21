--SUB QUERIES  (in -> select,partion by,insert ...)

Use [SQL TUTORIAL]
--Use in SELECT

SELECT Emp_Id,salary, 
(SELECT AVG(salary) FROM EMPLOYEES_SALARIES) AS AvgSalary
FROM EMPLOYEES_SALARIES;


--[2] Sub querries in PARTITION BY

SELECT EMP.Emp_ID,EMP.EmpName,Gender, 
AVG(SAL.salary) over (PARTITION BY Gender)  AS AvgSalaryByGender

FROM EMPLOYEES EMP
JOIN EMPLOYEES_SALARIES SAL
	ON EMP.emp_ID = SAL.emp_id




--SUBQUERY IN FROM Statement
--[3]Suppose you want to rank employees by their age within each gender group in the EMPLOYEES table.

SELECT Emp_ID,EmpName,salary,EmpRank
FROM(
	SELECT Emp.Emp_ID,Emp.EmpName,SAL.salary,
		ROW_NUMBER() OVER (PARTITION BY gender order by Emp.Age DESC) AS EmpRank
	FROM EMPLOYEES Emp
	JOIN EMPLOYEES_SALARIES SAL
		ON Emp.Emp_ID = SAL.emp_id
	) AS RankedEmployees
WHERE EmpRank <= 3     --TOP 3 EMPLOYEES within each gender group.	

EXEC GetEmployeesTBL


-----------------------------------

--SUBQUERY IN WHERE  , INSTEAD OF JOINING TABLES.

--Return MALE employees 
SELECT Emp_ID,EmpName,Age
FROM EMPLOYEES
WHERE Emp_ID IN (
		SELECT Emp_ID		--only select and send employ id whose age  > 30.
		FROM EMPLOYEES_SALARIES
		WHERE Gender = 'Male'
		) AND Age > 30
ORDER BY Age DESC





