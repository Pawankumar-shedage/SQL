
USE [SQL TUTORIAL]

select * from Prices

--QUESTIONS ON PRICES,Products,UnitsSold Table For DATES

--1. GETDATE and DATEADD:

--Q1: Write a query to display the product_id and start_date from the Prices table, along with a new column that 
--shows the date 30 days after the start_date using the DATEADD function.

select product_id,start_date,DATEADD(day,30,start_date) as date_after_30_days
from PRICES

--Q2: Find all products from the Prices table where 
--the end_date is within the next 15 days from the current date.

select GETDATE();	--return current sys date

SELECT product_id
from PRICES
where end_date BETWEEN GETDATE() AND DATEADD(day,15,GETDATE())

--2. DATEDIFF:
--Q3: Calculate the number of days between the start_date and end_date for each price record in the Prices table.

select *,DATEDIFF(day,start_date,end_date)as noOfDays
from PRICES

--Q4: Identify the products in the UnitsSold table where the purchase date occurred more than 30 days ago.

select * --,DATEDIFF(day,purchase_date,getdate()) 
from UnitsSold
WHERE  DATEDIFF(day,purchase_date,getdate()) > 2000

--3. DATEPART:

--Q5: Retrieve the product_id and the month part of the purchase_date from the UnitsSold table.

SELECT product_id,DATEPART(MONTH,purchase_date) as Month
from UnitsSold

--Q6: Find all records in the Prices table where the price was effective in February, regardless of the year.

SELECT *
FROM PRICES
WHERE DATEPART(MONTH,start_date) = 2 OR DATEPART(MONTH,end_date)=2


--4. FORMAT:

--Q7: Display the product_id, start_date, and end_date 
--from the Prices table with the dates formatted as Month-Day-Year.

select product_id,
FORMAT(start_date, 'MMM-dd-yyyy') as FormattedStartDate,
FORMAT(end_date,'ddd-dd-MMM-yyyy') as FormattedEndDate
from PRICES

--Q8: Retrieve the product_id and purchase_date from the UnitsSold table, and format the purchase_date to show the full month name.

SELECT 
    product_id, 
    FORMAT(purchase_date, 'MMMM yyyy') AS FormattedPurchaseDate
FROM UnitsSold;


--5. CONVERT:

--Q9: Write a query to display the product_id and start_date from the Prices table,
--converting the start_date to a string in the format YYYYMMDD. -> style code: 112   (ISO)

SELECT product_id,
	CONVERT(varchar,start_date,112)
from PRICES

--date style codes:   (ref:https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16)
	--112  -  'yyyymmdd'
	--101    -  'MM/DD/YYYY'   -US **imp
	--103   -   'dd/mm/yyyy'    -UK,French
	--23	 -  'yyyy-mm-dd'	
	--110	 -  'mm-dd-yyyy'	-USA