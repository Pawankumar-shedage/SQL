
SELECT *
FROM sys.tables

use [SQL TUTORIAL]


CREATE TABLE EmpBackUp
(
id int PRIMARY KEY,
EmpName nvarchar(50),
Age int,
Gender varchar(50)
)

------------------------------------------------------------
--(sys queries)

--Basic syntax

--CREATE TRIGGER [TriggerName]
--ON [TableName]
--AFTER | INSTEAD OF [INSERT, UPDATE, DELETE]
--AS
--BEGIN
--    -- Trigger logic here
--END;

--list of triggers 

SELECT name AS TriggerName, 
       OBJECT_NAME(parent_id) AS TableName, 
       type_desc AS TriggerType 
FROM sys.triggers;

--TRIGGER def

exec sp_helptext 'TrgEmpBackUP'

--Delete trg

--verfiy if it exists
SELECT name, object_id, parent_id
FROM sys.triggers
WHERE name = 'TrgEmpBackUP';


--BEGIN TRANSACTION 
DROP TRIGGER IF EXISTS TrgEmpBackUP

--ROLLBACK TRANSACTION


--------------------------------------------------------------------

--TRIGGER for backup. (DELETE)

CREATE TRIGGER TrgEmpBackUP
ON EMPLOYEES
INSTEAD OF DELETE 
AS
BEGIN	
	PRINT 'Before delete op'

	INSERT INTO EmpBackUp (id,EmpName,Age,Gender)
	SELECT * FROM  
	deleted;

	DELETE FROM EMPLOYEES
	WHERE Emp_ID IN (SELECT Emp_ID FROM deleted)

END;

--DELETE FROM EMPLOYEES
--WHERE Emp_ID = 1013

--------------------------------------------------------------------

--TRIGGER FOR INSERT And Update

CREATE TABLE EmpAuditTable
(
	AuditID INT IDENTITY(1,1) PRIMARY KEY,
    empID INT,
    OldName NVARCHAR(100),
    NewName NVARCHAR(100),
    OldAge INT,
    NewAge INT,
    OldGender NVARCHAR(10),
    NewGender NVARCHAR(10),
    UpdateDate DATETIME DEFAULT GETDATE(),
)

--ALTER TABLE EmpAuditTable
--ADD UpdatedBy NVARCHAR(100)

--AFTER INSESRT 

CREATE TABLE NewEmpRecords
(
 EmpID int,
 EmpName varchar(50),
 Age int,
 Gender varchar(50)
 )


CREATE TRIGGER TrgInsertRecords
ON EMPLOYEES
AFTER INSERT
AS 
BEGIN 
	PRINT 'Recorde inserted in EMPLOYEES table'
	insert into NewEmpRecords(EmpID,EmpName,Age,Gender)
	SELECT * FROM inserted
END;


--AFTER UPDATE TRIGGER

BEGIN TRANSACTION

CREATE TRIGGER TrgUpdateRecords
ON EMPLOYEES
AFTER UPDATE
AS 
BEGIN
	PRINT 'Records UPDATED in Employees table'
	INSERT INTO  EmpAuditTable(empID, OldName, NewName, OldAge, NewAge, OldGender, NewGender,UpdateDate)
	SELECT * FROM inserted i
	JOIN deleted d ON i.Emp_ID = d.Emp_ID
END

ROLLBACK TRANSACTION

--ALTER TRIGGER SYNTAX
ALTER TRIGGER TrgUpdateRecords
ON EMPLOYEES
AFTER UPDATE
AS 
BEGIN
	PRINT 'Records UPDATED in Employees Table'
	INSERT INTO  EmpAuditTable(empID, OldName, NewName, OldAge, NewAge, OldGender, NewGender,UpdateDate,UpdatedBy)
	SELECT 
		d.Emp_ID,
		d.EmpName,
		i.EmpName,
		d.Age,
		i.Age,
		d.Gender,
		i.Gender,
		GETDATE() AS UpdatedOn,
		SUSER_NAME() AS UpdatedBy
	FROM inserted i
	JOIN deleted d ON i.Emp_ID = d.Emp_ID
END

--DELETE TRIGGER trigger_name


--ops

INSERT INTO  EMPLOYEES
VALUES (8944,'Rajkumar Shedage',23,'Male')


UPDATE EMPLOYEES
SET EmpName = 'Lola Abenelle',Age = 34
WHERE Emp_ID = 1014 AND EmpName = 'Lola Angelio'

------------------------------------------------------------------------------



SELECT * FROM [SQL TUTORIAL]..EmpAuditTable

SELECT* from [SQL TUTORIAL]..NewEmpRecords

SELECT * FROM [SQL TUTORIAL].dbo.EMPLOYEES
order by Emp_ID desc

SELECT * FROM EmpBackUp






