--Working with view
--Display a list of medium_priced books
SELECT partnum, bktitle, slprice
FROM Titles
WHERE slprice BETWEEN 20 AND 40

--Create view
CREATE VIEW mediumprice
AS
SELECT partnum, bktitle, slprice
FROM Titles
WHERE slprice BETWEEN 20 AND 40

--Retrieve the view
SELECT *
FROM mediumprice

--Review the view definition
sp_helptext mediumprice

--Create a view named Salesperf to generate the top 20 list of books sold
CREATE VIEW salesperf
AS
SELECT TOP 20 Sales.partnum, Titles.bktitle, SUM(Sales.qty) AS 'Total Qty'
FROM Sales INNER JOIN Titles ON Sales.partnum = Titles.partnum
GROUP BY Sales.partnum, Titles.bktitle
ORDER BY SUM(Sales.qty) DESC

--Test the view
SELECT *
FROM salesperf

--Creating views with Schema Binding
--Create a view named sales_view with schema binding on the customers table
CREATE VIEW sales_view
WITH SCHEMABINDING
AS
SELECT CustName
FROM dbo.Customers

--Attaempt to alter the structure of the customers table
--we will have error message because the SCHEMABINDING prevents any changes to underliying tables that will cause the view to fail
ALTER TABLE Customers
ALTER COLUMN CustName varchar(30) NOT NULL

--Manipulating Data in views
--Insert the new book into the titles table by using the mediumprice view
INSERT mediumprice (partnum, bktitle, slprice)
VALUES ('40256', 'How to Play Violin (Intermediate)', 35)

INSERT mediumprice (partnum, bktitle, slprice)
VALUES ('40257', 'How to Play Violin (Advanced)', 39)


--Verify the changes
SELECT *
FROM mediumprice
WHERE partnum IN ('40256', '40257')

--Change the sale price of the book with partnum 40256 by using the mediumprice view
--update the sale price of the book with part number 40256 throught the mediumprice view
UPDATE mediumprice
SET slprice=30
WHERE partnum='40256'

--Verify that your change succeeded
SELECT *
FROM mediumprice
WHERE partnum='40256'

--Delete the record for the book with partnum 40234 using the mediumprice view
DELETE mediumprice
WHERE partnum='40234'

--Verify that you deleted the record 
SELECT *
FROM mediumprice
WHERE partnum='40234'

--Modifying and deleting view
--Copy the old view code
sp_helptext salesperf

--Right click in the result pane, and select all then select copy
--Then press Ctrl+V tp past text into the editor
CREATE VIEW salesperf  
AS  
SELECT TOP 20 Sales.partnum, Titles.bktitle, SUM(Sales.qty) AS 'Total Qty'  
FROM Sales INNER JOIN Titles ON Sales.partnum = Titles.partnum  
GROUP BY Sales.partnum, Titles.bktitle  
ORDER BY SUM(Sales.qty) DESC

--Revise the statment ,changing Create to Alter and 20 to 3 to returns only the top 3 books
ALTER VIEW salesperf    
AS    
SELECT TOP 3 Sales.partnum, Titles.bktitle, SUM(Sales.qty) AS 'Total Qty'    
FROM Sales INNER JOIN Titles ON Sales.partnum = Titles.partnum    
GROUP BY Sales.partnum, Titles.bktitle    
ORDER BY SUM(Sales.qty) DESC

--Verify that the view functions correctly,returns only the top 3 books
SELECT *
FROM salesperf

--Drop the mediumprice view and verify that you deleted it successfully
--Enter the statment Drop View 
DROP VIEW mediumprice

--Verify the view has been removed
SELECT *
FROM mediumprice























