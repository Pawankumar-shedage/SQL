--A PARTITION BY clause is used to partition rows of table into groups.
--It is useful when we have to perform a calculation on individual rows of a group using other rows of that group.
	--PARTION BY is always used inside OVER() Clause.
	--The partition formed by partition clause are also known as Window.
	--This clause works on windows functions only. Like- RANK(), LEAD(), LAG() etc.
	--If this clause is omitted in OVER() clause, then whole table is considered as a single partition.

--SIMILAR TO GROUP BY but different as GROUP BY collapses/groups rows, PARTITION BY divides the table into groups of rows.

-- PARTITION table rows on basis of gender. partions(window(s) of Male and Female)
SELECT Emp.EmpName, Emp.Gender,SAL.salary,
	COUNT(Emp.Gender) Over(PARTITION BY Emp.Gender) As TotalGender
FROM EMPLOYEES Emp
JOIN EMPLOYEES_SALARIES SAL
	ON Emp.Emp_ID = SAL.emp_id


--GROUP BY query similar to above query, to see difference in results
SELECT Gender, COUNT(Gender)
FROM EMPLOYEES
JOIN EMPLOYEES_SALARIES
	ON EMPLOYEES.Emp_ID = EMPLOYEES_SALARIES.emp_id
GROUP BY Gender


--QUESTIONS

SELECT * FROM EMPLOYEES

--[1] Write a query to calculate the cumulative sum of ages for each gender.
	SELECT Emp_ID,EmpName, Age, Gender,
		SUM(Age) OVER(PARTITION BY Gender ORDER BY Emp_ID) AS CumulativeAge
	From EMPLOYEES

--[2]Write a query to assign a row number to each employee within their respective gender.
	SELECT Emp_ID,EmpName, Age, Gender,
		ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY Emp_ID) AS RowNumb
	From EMPLOYEES


--[3]Write a query to calculate the average age within each gender while still displaying each employee's details.
SELECT Emp_ID,EmpName, Age, Gender,
	AVG(Age) OVER(PARTITION BY Gender) AS AvgAge
From EMPLOYEES


--[4]Write a query to rank employees by their age within their respective genders. **IMP
SELECT EmpName,Age,Gender,
	RANK() OVER (PARTITION BY gender order by age desc) AS EmpRank
FROM EMPLOYEES

--[5] Write a query to calculate the running total of ages for each gender. (SAME AS CUMULATIVE AGE QUERY)
		
	SELECT EmpName,age,gender,
		SUM(Age) OVER 
		(PARTITION BY gender order by emp_ID  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) 
		As RunningTotal
	FROM EMPLOYEES

	-- Based on gender col - Two partions are there Female AND Male
	--ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW : means first from the partition to the current row)
	-- eg for female partion :
			---> partion is from Pam to Gigi.  
			--Running total -> for Pam = 30, 
			--for Angela 30+ 31 = 61(Running tot of Pam + Age), 
			--for Meredith = 30 + 61 + 32(own age) = 93 and so on.. 
			--same for male (another partion)-> From Jim to Shantany Bhaskar.

--[6]Write a query to find the highest age in each gender while still displaying each employee's details.
SELECT EmpName,Age,Gender,	
	MAX(Age) Over (Partition by gender) as MaxAge
From EMPLOYEES


--[7]Write a query to calculate the difference between each employee's age and the average age of their gender.
SELECT EmpName,Age,Gender,	
	Age - AVG(Age) Over (Partition by gender) as AgeDifference
From EMPLOYEES


SELECT EmpName,Age,Gender,	
	Age * 100.0/SUM(Age) Over (Partition by gender) as DiffInBetweenAvgAge
From EMPLOYEES















