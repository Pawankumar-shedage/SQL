exec sp_help "EMPLOYEES_SALARIES"

use [SQL TUTORIAL]
/* Query for listing all tables in a DB*/
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'Base Table'
ORDER BY TABLE_NAME;

EXEC sp_rename 'EMPLOYEES_SALARIES.emp_name', 'emp_role', 'COLUMN'



SELECT Age, COUNT(Age) AS AGE_COUNT
from employees
group by Age  
order by age asc

select * from EMPLOYEES
order by 4 desc, 2 desc

