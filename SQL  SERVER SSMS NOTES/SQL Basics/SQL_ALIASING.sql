--ALIASING : temporay renaming columns and table names for the output,
--			 and for better readability of the SCRIPT.


--Col Aliasing
SELECT EmpName As EName FROM EMPLOYEES
SELECT EmpName  EName FROM EMPLOYEES

-- Table aliasing, ALIASING IS EFFICIENT AND READABLE SCRIPT.

SELECT EMP.EmpName,EMP.age,SAL.salary
FROM EMPLOYEES AS EMP
JOIN EMPLOYEES_SALARIES AS SAL
ON EMP.Emp_ID = SAL.emp_id
ORDER BY EMP.Age


--Aliasing is  useful in complex queries,many joins

SELECT Emps.EmpName, Emps.Gender, EmpSal.emp_role AS JobTitle, EmpSal.salary Salary
FROM [SQL TUTORIAL].dbo.EMPLOYEES Emps
LEFT JOIN [SQL TUTORIAL].dbo.EMPLOYEES_SALARIES EmpSal
	ON Emps.Emp_ID = EmpSal.emp_id

