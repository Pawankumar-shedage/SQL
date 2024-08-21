--STRING FUNCTIONS

--	TRIM,LTRIM,RTRIM, REPLACE, SUBSTRING**, UPPER,LOWER

--DROP TABLE EmployeeErrors

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
FROM EmployeeErrors

--1. TRIM

SELECT EmployeeID, TRIM(EmployeeID)
FROM EmployeeErrors;

SELECT EmployeeID, LTRIM(EmployeeID)
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID)
FROM EmployeeErrors

--final 
--BEGIN TRANSACTION 
	UPDATE  EmployeeErrors
	SET EmployeeID = TRIM(EmployeeID)
	

--COMMIT TRANSACTION
--ROLLBACK TRANSACTION
----------------------------------------

--Create custom sp.
--CREATE PROCEDURE sp_GetEmpErr
--AS
--BEGIN 
--	SELECT * 
--	FROM EmployeeErrors
--END;
--GO

EXEC sp_GetEmpErr

--2. SUBSTRING(String,start,lenght)     length= length_of_chars_to_extract from start position)

SELECT FirstName, SUBSTRING(FirstName,0,3)
FROM EmployeeErrors


SELECT FirstName, SUBSTRING(LastName,LEN(LastName)-4,5)
FROM EmployeeErrors

--BEGIN TRANSACTION

--ALTER TABLE EmployeeErrors
--ADD Initials varchar(5) DEFAULT 'FL' WITH VALUES;  --to fill existing rows with default values. use WITH VALUES

--COMMIT TRANSACTION
--ROLLBACK TRANSACTION

--ALTER TABLE EmployeeErrors
--DROP CONSTRAINT DF__EmployeeE__Initi__5CD6CB2B;

--ALTER TABLE EmployeeErrors
--DROP COLUMN Initials


--[2] REPLACE(string,'new value','old_value_to_replace')  3 args

SELECT lastname,REPLACE(lastname,'- Fired','') As LastNameFixed
FROM EmployeeErrors

--final updt
UPDATE EmployeeErrors
SET LastName = REPLACE(lastname,'- Fired','')
WHERE EmployeeID = '1005'
--------------------------------------------------------------------------

-- Query to Get initials
SELECT firstname,lastname, SUBSTRING(FirstName,1,1) + SUBSTRING(LastName,1,1) AS Initials
from EmployeeErrors



--[3]UPPER,LOWER
SELECT FirstName, UPPER(FirstName)
From EmployeeErrors

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors;

use [SQL TUTORIAL]
EXEC  sp_GetEmpErr

--[4]CHARINDEX('substring','string') return the starting position of substring in the main string. IMP
	--Used for Searching.

SELECT FirstName,CHARINDEX('bo',FirstName) As Op
FROM EmployeeErrors

--ALTER TABLE EmployeeErrors
--ADD Email varchar(50)

--SELECT *, LOWER(FirstName)+SUBSTRING(LOWER(LastName),1,3) +'@gmail.com' AS Email
--FROM EmployeeErrors

----Setting up emails.
--UPDATE EmployeeErrors
--SET Email = LOWER(FirstName)+SUBSTRING(LOWER(LastName),1,3) +'@gmail.com'

--Extracting domain from email
SELECT FirstName, SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)) AS Domain
FROM EmployeeErrors

EXEC  sp_GetEmpErr
--------------------------------------------------------------

--QUERY TO CONCAT COLUMNS
SELECT CONCAT(FirstName,' ',LastName) AS FullName
FROM EmployeeErrors


--Find the position of a specific character in names: 'a'.
SELECT FirstName, CHARINDEX('a',FirstName) As Position
FROM EmployeeErrors









