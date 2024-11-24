/*  
                                      Project Name : Super Shop Management System 
											Trainee Name : Jasmin Akhter 
						    				  Trainee ID : 1285546       
										    Batch ID : CS/PNTL-A/62/01

									--------------*********-------------------
DML Containt Details:
				PORTION 01:	Insert Data Using Insert Into Keyword
				PORTION 02:	Select Query 
				PORTION 03:	Update Query
				PORTION 04:	Delete Query
				PORTION 05:	Query for Show Sales Details
				PORTION 06: Using Join & Order By	
				PORTION 07:	Retrieve Sales Information Using JOIN, WHERE and ORDER BY
				PORTION 08:	Left Join
				PORTION 09:	Right Join
				PORTION 10:	Aggregate Function 
				PORTION 11: Insert Data Into Sequence
				PORTION 12:	Testing Trigger (After Trigger)
				PORTION 13:	Testing Trigger (Insted of Trigger)
				PORTION 14: Testing Function	
				PORTION 15:	Sub Query with TOP Clause
				PORTION 16: CTE with Sub Query
				PORTION 17: Recursive CTE with UNION
				PORTION 18: Case
				PORTION 19: Marge
				PORTION 20: Union
				PORTION 21: CAST, CONVERT
				PORTION 22: IF, ELSE, PRINT
				PORTION 23: IIF & CHOOSE
				PORTION 24: Logical Operator
				PORTION 25: Built in Functions
			    PORTION 26: Aggregate Functions

				
*/




--==>Using Database For Working on it

USE Shop_Management_DB
GO

                    -----============* ///PORTION 01/// *============-----
-------=====================INSERT DATA USING INSERT INTO KEYWORD==========================---------
INSERT INTO ProductCategory (CategoryName)
VALUES 
    ('Beverages'),
    ('Snacks'),
    ('Dairy Products'),
    ('Personal Care'),
    ('Cleaning Supplies');
GO
INSERT INTO Product (ProductName, CategoryID, ProductPrice, QuantityInStock)
VALUES 
    ('Coca Cola', 1, 35.00, 100),
    ('Pepsi', 1, 30.00, 120),
    ('Orange Juice', 1, 50.00, 80),
    ('Mineral Water', 1, 15.00, 200),
    ('Iced Tea', 1, 35.00, 150),

	('Potato Chips', 2, 20.00, 250),
    ('Pretzels', 2, 70.00, 150),
    ('Popcorn', 2, 30.50, 100),
    ('Chocolate Bar', 2, 45.00, 200),
    ('Trail Mix', 2, 35.50, 90),

	('Milk', 3, 120.00, 300),
    ('Cheese', 3, 250.50, 100),
    ('Yogurt', 3, 450.00, 120),
    ('Butter', 3, 350.50, 80),
    ('Cream', 3, 270.00, 60),

	('Shampoo', 4, 250.00, 50),
    ('Toothpaste', 4, 120.00, 100),
    ('Soap', 4, 60.00, 200),
    ('Lotion', 4, 230.00, 40),
    ('Deodorant', 4, 450.00, 80),

	('Dish Soap', 5, 45.00, 150),
    ('Laundry Detergent', 5, 120.00, 100),
    ('Bleach', 5, 80.00, 80),
    ('Glass Cleaner', 5, 70.00, 90),
    ('Floor Cleaner', 5, 70.00, 60);
GO
INSERT INTO Supplier (SupplierName, ContactPerson, Phone, Email, Address)
VALUES 
    ('ABC Beverages Ltd.', 'Mamun Rashid', '01345678901', 'contact@abcbeverages.com', '101 Beverage St'),
    ('Snacks Unlimited', 'Jabran Iqbal', '01987654321', 'info@snacksunlimited.com', '202 Snack Blvd'),
    ('Daily Dairy Supply Co.', 'Jahangir Alam', '01522334455', 'support@dairysupply.com', '303 Dairy Ln'),
    ('Personal Care Products Inc.', 'Murshida Alam', '01556677889', 'sales@pcpinc.com', '404 Care Ave'),
    ('Clean & Green Suppliers', 'Karim Khan', '01667788990', 'service@cleangreen.com', '505 Clean Rd')
GO
INSERT INTO ProductSupplier (ProductID, SupplierID)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), 
		(6, 1), (7, 2), (8, 3), (9, 4), (10, 5),
		(11, 1), (12, 2), (13, 3), (14, 4), (15, 5),
		(16, 1), (17, 2), (18, 3), (19, 4), (20, 5),
		(21, 1), (22, 2), (23, 3), (24, 4), (25, 5); 
GO
INSERT INTO Purchase (SupplierID, PurchaseDate, TotalAmount)
VALUES 
    (1, GETDATE(), 0), 
    (2, GETDATE(), 0), 
    (3, GETDATE(), 0), 
    (4, GETDATE(), 0), 
    (5, GETDATE(), 0);
GO
INSERT INTO PurchaseDetail (PurchaseID, ProductID, Quantity, PurchasePrice)
VALUES 
    -- Beverages
    (1, 1, 100, 35.00), -- Coca Cola
    (1, 2, 120, 30.00), -- Pepsi
    (1, 3, 80, 50.00),  -- Orange Juice
    (1, 4, 200, 15.00), -- Mineral Water
    (1, 5, 150, 35.00), -- Iced Tea

    -- Snacks
    (2, 6, 250, 20.00), -- Potato Chips
    (2, 7, 150, 70.00), -- Pretzels
    (2, 8, 100, 30.50), -- Popcorn
    (2, 9, 200, 45.00), -- Chocolate Bar
    (2, 10, 90, 35.50), -- Trail Mix

    -- Dairy Products
    (3, 11, 300, 120.00), -- Milk
    (3, 12, 100, 250.50), -- Cheese
    (3, 13, 120, 450.00), -- Yogurt
    (3, 14, 80, 350.50),  -- Butter
    (3, 15, 60, 270.00),  -- Cream

    -- Personal Care 
    (4, 16, 50, 250.00), -- Shampoo
    (4, 17, 100, 120.00), -- Toothpaste
    (4, 18, 200, 60.00),  -- Soap
    (4, 19, 40, 230.00),  -- Lotion
    (4, 20, 80, 450.00),  -- Deodorant

    -- Cleaning Supplies 
    (5, 21, 150, 45.00),  -- Dish Soap
    (5, 22, 100, 120.00), -- Laundry Detergent
    (5, 23, 80, 80.00),   -- Bleach
    (5, 24, 90, 70.00),   -- Glass Cleaner
    (5, 25, 60, 70.00);   -- Floor Cleaner
GO



---==> Query for show purchase details
SELECT 
    p.PurchaseID,
    p.SupplierID,
    s.SupplierName,
    SUM(pd.Quantity * pd.PurchasePrice) AS CalculatedTotal,
    p.TotalAmount
FROM Purchase p
JOIN PurchaseDetail pd ON p.PurchaseID = pd.PurchaseID
JOIN Supplier s ON p.SupplierID = s.SupplierID
GROUP BY p.PurchaseID, p.SupplierID, s.SupplierName, p.TotalAmount;



GO
INSERT INTO Customer (Name, Phone, Email, Address)
VALUES 
    ('Sadid Mursalin', '01233211234', 'sadid.mursalin@email.com', '101 Main St'),
    ('Arif Islam', '01987654321', 'arif.islam@email.com', '202 Oak St'),
    ('Sakeb khondokar', '01122334455', 'khondokar.sakib@email.com', '303 Pine St'),
    ('Lisa Alam', '01334455667', 'lisa.alam@email.com', '404 Maple Ave')
GO
INSERT INTO Sales (CustomerID, SaleDate, TotalAmount)
VALUES 
    (1, GETDATE(), 0), -- Sadid Mursalin
    (2, GETDATE(), 0), -- Arif Islam
    (3, GETDATE(), 0), -- Sakeb Khondokar
    (4, GETDATE(), 0); -- Lisa Alam
GO
INSERT INTO SalesDetail (SaleID, ProductID, Quantity, Price)
VALUES 
    -- Sales for Sadid Mursalin (SaleID = 1)
    (1, 1, 2, 35.00), -- Coca Cola
    (1, 2, 3, 30.00), -- Pepsi
    (1, 3, 1, 50.00), -- Orange Juice

    -- Sales for Arif Islam (SaleID = 2)
    (2, 6, 5, 20.00), -- Potato Chips
    (2, 7, 2, 70.00), -- Pretzels
    (2, 8, 4, 30.50), -- Popcorn

    -- Sales for Sakeb Khondokar (SaleID = 3)
    (3, 11, 1, 120.00), -- Milk
    (3, 12, 2, 250.50), -- Cheese
    (3, 13, 1, 450.00), -- Yogurt

    -- Sales for Lisa Alam (SaleID = 4)
    (4, 16, 1, 250.00), -- Shampoo
    (4, 17, 3, 120.00), -- Toothpaste
    (4, 18, 2, 60.00),  -- Soap
	(4, 19, 3, 90.00);  -- Soap
GO



                  -----============*///PORTION 02///*============-----
-------============================= Select Query  ==========================---------

SELECT * FROM ProductCategory;
SELECT * FROM Product;
SELECT * FROM ProductSupplier;
SELECT * FROM Purchase;
SELECT * FROM PurchaseDetail;
SELECT * FROM Customer;
SELECT * FROM Sales;
SELECT * FROM SalesDetail;
SELECT * FROM  ProductAudit;
SELECT * FROM SupplierAudit;



                  -----============* ///PORTION 03/// *============-----
-------=============================== Update Query ==========================---------

-- Update total amounts in the Purchase table
UPDATE p
SET TotalAmount = (
    SELECT SUM(pd.Quantity * pd.PurchasePrice)
    FROM PurchaseDetail pd
    WHERE pd.PurchaseID = p.PurchaseID
)
FROM Purchase p;
SELECT * FROM Purchase;
SELECT * FROM PurchaseDetail;
GO
-- Update total amounts in the Sales table
UPDATE s
SET TotalAmount = (
    SELECT SUM(sd.Quantity * sd.Price)
    FROM SalesDetail sd
    WHERE sd.SaleID = s.SaleID
)
FROM Sales s;
GO
SELECT * FROM Sales;
SELECT * FROM SalesDetail;
GO



                  -----============* ///PORTION 04/// *============-----
-------=============================== Delete Query ==========================---------

DELETE FROM SalesDetail WHERE SalesDetailID = 13;






                  -----============* ///PORTION 05/// *============-----
-------======================= Query for Show Sales Details ==========================---------

SELECT 
    s.SaleID,
    s.CustomerID,
    c.Name AS CustomerName,
    SUM(sd.Quantity * sd.Price) AS CalculatedTotal,
    s.TotalAmount
FROM Sales s
JOIN SalesDetail sd ON s.SaleID = sd.SaleID
JOIN Customer c ON s.CustomerID = c.CustomerID
GROUP BY s.SaleID, s.CustomerID, c.Name, s.TotalAmount;
GO



                  -----============* ///PORTION 06/// *============-----
-------========================== Using Join & Order By  ==========================---------

--==> Retrieve Sales information using JOIN and ORDER BY
SELECT 
    s.SaleID,
    c.Name AS CustomerName,
    p.ProductName,
    sd.Quantity,
    sd.Price,
    sd.Quantity * sd.Price AS TotalPrice,
    s.SaleDate
FROM Sales s
INNER JOIN Customer c ON s.CustomerID = c.CustomerID
INNER JOIN SalesDetail sd ON s.SaleID = sd.SaleID
INNER JOIN Product p ON sd.ProductID = p.ProductID
ORDER BY s.SaleId DESC;



                  -----============* ///PORTION 07/// *============-----
-------============ Retrieve Sales Information Using JOIN, WHERE and ORDER BY ==========================---------

--==> Retrieve Sales information using JOIN, WHERE and ORDER BY
SELECT 
    s.SaleID,
    c.Name AS CustomerName,
    p.ProductName,
    sd.Quantity,
    sd.Price,
    sd.Quantity * sd.Price AS TotalPrice,
    s.SaleDate
FROM Sales s
INNER JOIN Customer c ON s.CustomerID = c.CustomerID
INNER JOIN SalesDetail sd ON s.SaleID = sd.SaleID
INNER JOIN Product p ON sd.ProductID = p.ProductID
WHERE c.Phone = '01987654321'
ORDER BY s.SaleId;



                  -----============* ///PORTION 08/// *============-----
-------=============================== Left Join ==========================---------

--==> Retrieve Product information using LEFT JOIN
SELECT 
    p.ProductID,
    p.ProductName,
    pc.CategoryName,
    ps.SupplierID,
    s.SupplierName
FROM Product p
LEFT JOIN ProductCategory pc ON p.CategoryID = pc.CategoryID
LEFT JOIN ProductSupplier ps ON p.ProductID = ps.ProductID
LEFT JOIN Supplier s ON ps.SupplierID = s.SupplierID;



                  -----============* ///PORTION 09/// *============-----
-------============================ Right Join ==========================---------

--==> Retrieve Purchase information using RIGHT JOIN
SELECT 
    pur.PurchaseID,
    s.SupplierName,
    pd.ProductID,
    p.ProductName,
    pd.Quantity,
    pd.PurchasePrice,
    pd.Quantity * pd.PurchasePrice AS TotalCost,
    pur.PurchaseDate
FROM Purchase pur
RIGHT JOIN Supplier s ON pur.SupplierID = s.SupplierID
RIGHT JOIN PurchaseDetail pd ON pur.PurchaseID = pd.PurchaseID
RIGHT JOIN Product p ON pd.ProductID = p.ProductID;



                -----============* ///PORTION 10/// *============-----
-------========================== Aggregate Function ==========================---------

SELECT 
    c.Name AS CustomerName,
    p.ProductName,
    COUNT(s.SaleID) AS TotalSalesCount,                   
    SUM(sd.Quantity) AS TotalSaleQuantity,                
    AVG(sd.Price) AS AverageSalePrice,                    
    MIN(sd.Price) AS MinSalePrice,                        
    MAX(sd.Price) AS MaxSalePrice,                        
    COUNT(DISTINCT ps.SupplierID) AS UniqueSupplierCount, 
    SUM(pd.Quantity) AS TotalPurchaseQuantity,            
    SUM(pd.PurchasePrice * pd.Quantity) AS TotalPurchaseCost 
FROM Sales s
INNER JOIN Customer c ON s.CustomerID = c.CustomerID
INNER JOIN SalesDetail sd ON s.SaleID = sd.SaleID
INNER JOIN Product p ON sd.ProductID = p.ProductID
LEFT JOIN ProductSupplier ps ON p.ProductID = ps.ProductID
LEFT JOIN Supplier sup ON ps.SupplierID = sup.SupplierID
LEFT JOIN PurchaseDetail pd ON pd.ProductID = p.ProductID
GROUP BY 
    c.Name, 
    p.ProductName        
HAVING 
    SUM(sd.Quantity) > 2  
    AND SUM(pd.Quantity) > 10; 
GO
SELECT * FROM SalesDetail;




                   -----============* ///PORTION 11/// *============-----
-------======================== Insert Data Into Sequence ==========================---------


INSERT INTO Purchase (SupplierID, PurchaseDate, TotalAmount)
VALUES (1, '2024-11-14', 1500.00);

INSERT INTO Purchase (SupplierID, TotalAmount) VALUES (2, 3200.00); 
GO
SELECT * FROM Purchase
GO


                  -----============* ///PORTION 12/// *============-----
-------======================= Testing Trigger (After Trigger) ==========================---------


EXEC sp_Customer_Insert 
    @Name = 'John Doe', 
    @Phone = '0123456789', 
    @Email = 'johndoe@email.com', 
    @Address = '123 Main St', 
    @RegistrationDate = '2024-11-02';
GO
SELECT * FROM Customer ORDER BY CustomerID DESC;

EXEC sp_Customer_Update 
    @CustomerID = 5, 
    @Name = 'Jane Doe', 
    @Phone = '0987654321', 
    @Email = 'janedoe@email.com', 
    @Address = '456 Oak St', 
    @RegistrationDate = '2024-11-01';
GO


EXEC sp_Customer_Delete @CustomerID = 5;
GO



--==>Testing the AFTER/FOR TRIGGER's
GO
INSERT INTO Product (ProductName, CategoryID, ProductPrice, QuantityInStock)
VALUES ('Sample Product', 1, 10.99, 100);
GO
UPDATE Product
SET ProductPrice = 15.99, QuantityInStock = 80
WHERE ProductID = 26;
GO
DELETE FROM Product WHERE ProductID = 26;
GO



                  -----============* ///PORTION 13/// *============-----
-------======================= Testing Trigger (Insted of Trigger) ==========================---------


GO
INSERT INTO Supplier (SupplierName, ContactPerson, Phone, Email, Address)
VALUES ('ABC Supplies', 'John Doe', '1234567890', 'abc@supplies.com', '123 Market St');
GO
UPDATE Supplier
SET Phone = '0987654321', Address = '456 Elm St'
WHERE SupplierID = 6;
GO
DELETE FROM Supplier WHERE SupplierID = 6;
GO
SELECT * FROM SupplierAudit;
GO
SELECT * FROM Supplier ORDER BY SupplierID dESC;



             -----============* ///PORTION 14/// *============-----
-------======================= Testing Function ==========================---------



--==> Scalar Function

DECLARE @TotalSales DECIMAL(10, 2);

SET @TotalSales = dbo.fn_GetTotalSalesForDay(GETDATE()); 

SELECT @TotalSales AS TotalSalesForDay;
GO


--==>Table Valued Function

SELECT * FROM fn_GetProductDetailsByProductID(1);
GO



--==> Multi-Statement Function

SELECT * FROM dbo.fn_GetSalesDetailsForDay(GETDATE());
GO



                -----============* ///PORTION 15/// *============-----
-------======================= Sub Query with TOP Clause ==========================---------



SELECT pc.CategoryName, SUM(sd.Quantity) AS TotalQuantitySold
FROM ProductCategory pc
JOIN Product p ON pc.CategoryID = p.CategoryID
JOIN SalesDetail sd ON p.ProductID = sd.ProductID
WHERE pc.CategoryID = 
(
        SELECT TOP 1 pc2.CategoryID
        FROM ProductCategory pc2
        JOIN Product p2 ON pc2.CategoryID = p2.CategoryID
        JOIN SalesDetail sd2 ON p2.ProductID = sd2.ProductID
        GROUP BY pc2.CategoryID
        ORDER BY SUM(sd2.Quantity) DESC
)
GROUP BY pc.CategoryName;
GO




             -----============* ///PORTION 16/// *============-----
-------======================= CTE with Sub Query ==========================---------



WITH CTE_CategorySales AS 
(
    SELECT pc.CategoryName, SUM(sd.Quantity * sd.Price) AS TotalSalesAmount
    FROM ProductCategory pc
    JOIN Product p ON pc.CategoryID = p.CategoryID
    JOIN SalesDetail sd ON p.ProductID = sd.ProductID
    GROUP BY pc.CategoryName
)
SELECT CategoryName, TotalSalesAmount
FROM CTE_CategorySales
WHERE TotalSalesAmount = 
(
        SELECT MAX(TotalSalesAmount) 
        FROM CTE_CategorySales
);
GO



                -----============* ///PORTION 17/// *============-----
-------======================= Recursive CTE with UNION ==========================---------


WITH CTE_Numbers AS (
    
    SELECT 1 AS n

    UNION ALL

   
    SELECT n + 1
    FROM CTE_Numbers
    WHERE n < 10 
)

SELECT n
FROM CTE_Numbers
OPTION (MAXRECURSION 10);  
GO



             -----============* ///PORTION 18/// *============-----
-------============================= CASE ==========================---------------


SELECT ProductName, ProductPrice,
    CASE 
        WHEN ProductPrice < 6 THEN 'Cheap'
        WHEN ProductPrice >= 6 AND ProductPrice <= 10 THEN 'Affordable'
        WHEN ProductPrice > 10 THEN 'Expensive'
        ELSE 'Unknown'
    END AS PriceCategory
FROM Product;
GO




             -----============* ///PORTION 19/// *============-----
-------============================= MERGE ==========================---------------


-- MERGE statement for the Product table
MERGE Product AS Target
USING Product AS Source
ON Target.ProductID = Source.ProductID

-- When Matched, update the product details
WHEN MATCHED THEN
    UPDATE SET 
        Target.ProductName = Source.ProductName,
        Target.ProductPrice = Source.ProductPrice,
        Target.QuantityInStock = Source.QuantityInStock

-- When Not Matched, insert the product into the table
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductName, ProductPrice, QuantityInStock)  
    VALUES (Source.ProductName, Source.ProductPrice, Source.QuantityInStock);
GO
-- Show the results after the MERGE operation
SELECT * FROM Product;



             -----============* ///PORTION 20/// *============-----
-------============================= UNION ==========================---------------
SELECT CategoryName AS Name, 'Category' AS Type
FROM ProductCategory

UNION

SELECT ProductName AS Name, 'Product' AS Type
FROM Product;
GO



             -----============* ///PORTION 21/// *============-----
-------======================== CAST, CONVERT ==========================---------------


SELECT 
    CAST(PurchaseDate AS DATE) AS CastDate,
    CONVERT(VARCHAR(10), PurchaseDate, 103) AS ConvertDate 
FROM Purchase;
GO



             -----============* ///PORTION 22/// *============-----
-------========================= IF, ELSE, PRINT ==========================---------------


DECLARE @ProductName NVARCHAR(100);
SET @ProductName = 'Laptop';

IF EXISTS (SELECT 1 FROM Product WHERE ProductName = @ProductName)
BEGIN
    PRINT 'Product exists in the database.';
END
ELSE
BEGIN
    PRINT 'Product does not exist in the database.';
END;
GO



             -----============* ///PORTION 23/// *============-----
-------========================= IIF & CHOOSE ==========================---------------


SELECT ProductName, 
    IIF(QuantityInStock < 10, 'Low Stock', 'In Stock') AS StockStatus 
FROM Product;

GO


SELECT ProductName,
	CHOOSE(CategoryID, 'Electronics', 'Clothing', 'Food') AS CategoryName 
FROM Product;




             -----============* ///PORTION 24/// *============-----
-------========================= Logical Operator ==========================---------------


SELECT ProductID, ProductName, ProductPrice
FROM Product
WHERE CategoryID = 1 AND ProductPrice > 50;
Go

SELECT SupplierID, SupplierName, Phone, Email
FROM Supplier
WHERE Phone LIKE '123%' OR Email LIKE '%@gmail.com';
GO

SELECT ProductID, ProductName, CategoryID
FROM Product
WHERE NOT CategoryID = 1;
GO

SELECT CustomerID, Name, Phone
FROM Customer
WHERE CustomerID IN (1, 2, 3);
GO

SELECT PurchaseID, SupplierID, PurchaseDate, TotalAmount
FROM Purchase
WHERE PurchaseDate BETWEEN '2023-01-01' AND '2023-12-31';
GO


SELECT PurchaseID, SupplierID, PurchaseDate, TotalAmount
FROM Purchase
WHERE PurchaseDate BETWEEN '2023-01-01' AND '2023-12-31' 
   OR TotalAmount > 1000;



             -----============* ///PORTION 25/// *============-----
-------========================= Built in Functions ==========================---------------



SELECT SupplierID, SupplierName, LEN(SupplierName) AS SupplierNameLength
FROM Supplier;
GO


SELECT CustomerID, Name, RegistrationDate, DATEDIFF(DAY, RegistrationDate, GETDATE()) AS DaysRegistered
FROM Customer;
GO


SELECT SupplierID, UPPER(SupplierName) AS SupplierNameUpper
FROM Supplier;
GO


SELECT SupplierID, LOWER(SupplierName) AS SupplierNameUpper
FROM Supplier;
GO


SELECT SupplierID, CONCAT(SupplierName, ' - ', ContactPerson) AS SupplierContactInfo
FROM Supplier;
GO


SELECT PurchaseID, SupplierID, ROUND(TotalAmount, 2) AS RoundedTotalAmount
FROM Purchase;
GO


SELECT CustomerID, Name, ISNULL(Phone, 'Not Available') AS Phone
FROM Customer;
GO


SELECT PurchaseID, PurchaseDate, 
       DATEPART(YEAR, PurchaseDate) AS PurchaseYear,
       DATEPART(MONTH, PurchaseDate) AS PurchaseMonth
FROM Purchase;
GO


SELECT CustomerID, Name, COALESCE(Phone, 'No Phone') AS CustomerPhone
FROM Customer;
GO


SELECT ProductID, LEFT(ProductName, 3) AS First3CharsOfProductName
FROM Product;
GO


SELECT SupplierID, RIGHT(Phone, 4) AS Last4DigitsOfPhone
FROM Supplier;
GO


SELECT ProductID, ProductName, ProductPrice, 
       RANK() OVER (PARTITION BY CategoryID ORDER BY ProductPrice DESC) AS PriceRank
FROM Product;
GO

   
   
              -----============* ///PORTION 26/// *============-----
-------========================= Aggregate Functions ==========================---------------


-- Get the total sales for each product
SELECT ProductID, SUM(Quantity) AS TotalQuantitySold
FROM SalesDetail
GROUP BY ProductID;
GO

-- Get the average purchase price for each product
SELECT ProductID, AVG(PurchasePrice) AS AvgPurchasePrice
FROM PurchaseDetail
GROUP BY ProductID;
GO

-- Get the number of products in each category
SELECT CategoryID, COUNT(ProductID) AS ProductCount
FROM Product
GROUP BY CategoryID;
GO

-- Get the minimum and maximum prices of products
SELECT MIN(ProductPrice) AS MinPrice, MAX(ProductPrice) AS MaxPrice
FROM Product;
GO

---------------------------------------------------*******************************---------------------------------------
