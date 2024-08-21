
--Removing Duplicates

WITH RemoveDupsCTE
AS (
	select *, 
	RANK() OVER (PARTITION BY EmpName ORDER BY EMP_ID) AS RANK
	--ROW_NUMBER() OVER (PARTITION BY EmpName ORDER BY EMP_ID) AS RowNum    --carefull while using partitionby.
	FROM EMPLOYEES
)
SELECT *
--DELETE
FROM RemoveDupsCTE
WHERE Emp_ID IN 
	(
		SELECT Emp_ID
		FROM RemoveDupsCTE
		--WHERE Rank > 1
	);


DELETE FROM EMPLOYEES
WHERE Emp_ID = 8943 AND EmpName = 'SDK'

INSERT INTO EMPLOYEES VALUES (5847,'Pawankumar Shedage',23,'Male')


SELECT * FROM [SQL TUTORIAL].dbo.EMPLOYEES
order by Emp_ID desc