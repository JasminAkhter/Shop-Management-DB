/*  
                                      Project Name : Super Shop Management System 
											Trainee Name : Jasmin Akhter 
						    				  Trainee ID : 1285546       
										    Batch ID : CS/PNTL-A/62/01

									--------------*********-------------------
DDL Containt Details:
				PORTION 01:	Creating Database
				PORTION 02:	Using Database for Working on It 
				PORTION 03:	Creating Database Related Tables 
				PORTION 04:	Creating Table for Create Index, Alter & Drop 
				PORTION 05:	Sequence Creating 
				PORTION 06:	Creating View 
				PORTION 07:	Store Procedure 
				PORTION 08:	Trigger(After Trigger) 
				PORTION 09:	Trigger(Instead of Trigger) 
				PORTION 10:	Functions
				
*/



                   -----============* ///PORTION 01/// *============-----
-------==============================CREATING DATABASE=============================---------

Create Database Shop_Management_DB
ON
(
	Name = Shop_Management_DB_Data_1,
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Shop_Management_DB_Data_1.mdf',
	Size = 25MB,
	MaxSize = 200MB,
	FileGrowth = 5%
)
LOG ON
(
	Name = Shop_Management_DB_Log_1,
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Shop_Management_DB_Log_1.ldf',
	Size = 2MB,
	MaxSize = 25MB,
	FileGrowth = 1%
)
Print ('Congratulations! A Database with name ''Shop_Management_DB'' Created Successfully.');
Go



                    -----============* ///PORTION 02/// *============-----
-------========================USING DATABASE FOR WORKING ON IT=========================---------


USE Shop_Management_DB
Print ('Welcome! Shop_Management_DB Database now in use. Lets Working On I''t.');
Go



                      -----============*///PORTION 03///*============-----
-------==========================CREATING DATABASE RELATED TABLES===========================---------



--==>Table 1
CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE
);
GO



--==>Table 2
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES ProductCategory(CategoryID) NOT NULL,
    ProductPrice DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT DEFAULT 0
);
GO



--==>Table 3
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(100),
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(255)
);
GO



--==>Table 4
CREATE TABLE ProductSupplier
(
	ProductSupplierID INT PRIMARY KEY IDENTITY(1, 1),
	ProductID INT FOREIGN KEY REFERENCES Product(ProductID) NOT NULL,
	SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID) NOT NULL
);
GO



--==>Table 5
CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY IDENTITY,
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID) NOT NULL,
    PurchaseDate DATE DEFAULT GETDATE() CHECK (PurchaseDate <= GETDATE()),
    TotalAmount DECIMAL(10, 2) CHECK (TotalAmount >= 0)
);
GO



--==>Table 6
CREATE TABLE PurchaseDetail (
    PurchaseDetailID INT PRIMARY KEY IDENTITY,
    PurchaseID INT FOREIGN KEY REFERENCES Purchase(PurchaseID) NOT NULL,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID) NOT NULL,
    Quantity INT NOT NULL,
    PurchasePrice DECIMAL(10, 2) NOT NULL
);
GO



--==>Table 7
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(255),
    RegistrationDate DATE DEFAULT GETDATE()
);
GO



--==>Table 8
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL,
    SaleDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2)
);
GO



--==>Table 9
CREATE TABLE SalesDetail (
    SalesDetailID INT PRIMARY KEY IDENTITY,
    SaleID INT FOREIGN KEY REFERENCES Sales(SaleID) NOT NULL,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID) NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);
GO

--==>Table's for Auditing, Used in TRIGGER's

--==>Table 10
CREATE TABLE SupplierAudit (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    Action NVARCHAR(50),
    Details NVARCHAR(MAX),
    AuditDate DATETIME DEFAULT GETDATE()
);
GO

--==>Table 11
CREATE TABLE ProductAudit
(
	AuditID INT PRIMARY KEY IDENTITY (1, 1),
	AuditDescription VARCHAR (200),
	AuditDate DATETIME DEFAULT GETDATE()
);
GO





                      -----============* ///PORTION 04/// *============-----
-------=====================CREATING TABLE for Create INDEX, ALTER, & DROP ==========================---------


--==> Table Creating
CREATE TABLE CustomerAddress
(
	CustomerAddressID INT,
	CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
	CustomerShippingAddress VARCHAR(MAX)
);
Go



--==> TABLE ALTER
ALTER TABLE CustomerAddress ADD CustomerBillingAddress VARCHAR (MAX);
GO
ALTER TABLE CustomerAddress ALTER COLUMN CustomerBillingAddress NVARCHAR(500) NOT NULL;
GO
ALTER TABLE CustomerAddress DROP COLUMN CustomerBillingAddress;
GO



--==> CLUSTERED INDEX
CREATE CLUSTERED INDEX ix_CustomerAddress_CustomerAddressID ON CustomerAddress (CustomerAddressID);
GO
DROP INDEX CustomerAddress.ix_CustomerAddress_CustomerAddressID;
GO
--==> NONCLUSTERED INDEX
CREATE NONCLUSTERED INDEX ix_CustomerAddress_CustomerID ON CustomerAddress (CustomerID);
GO
--==> DROP INDEX
DROP INDEX CustomerAddress.ix_CustomerAddress_CustomerID;
Go



--==> DROP TABLE
DROP TABLE CustomerAddress;
GO



                    -----============* ///PORTION 05/// *============-----
-------================================CREATE SEQUENCE=============================---------


CREATE SEQUENCE PurchaseSeq
    START WITH 1
    Increment BY 1
    MinValue 1
    MaxValue 100
    NO Cycle 
GO



                    -----============* ///PORTION 06/// *============-----
-------===============================CREATEING VIEW=============================---------



--===> VIEW
CREATE VIEW v_Product AS
SELECT p.ProductID, p.ProductName, p.ProductPrice, pc.CategoryName, s.SupplierName, 
		s.Phone, prc.PurchaseDate, prc.TotalAmount, prcd.Quantity, prcd.PurchasePrice
FROM Product AS P
JOIN ProductCategory AS pc ON p.CategoryID = pc.CategoryID
JOIN ProductSupplier As ps ON p.ProductID = ps.ProductID
JOIN Supplier AS s ON ps.SupplierID = s.SupplierID
JOIN Purchase AS prc ON s.SupplierID = prc.SupplierID
JOIN PurchaseDetail AS prcd ON p.ProductID = prcd.ProductID;
GO



--===> VIEW WITH SCHEMABINDING & ENCRYPTION
CREATE VIEW	dbo.vw_Sales 
WITH SCHEMABINDING, ENCRYPTION 
AS
SELECT s.SaleID, s.SaleDate, c.Name AS CustomerName, c.Phone, p.ProductName, sd.Quantity, sd.Price, s.TotalAmount  
       
FROM dbo.Sales AS s
JOIN dbo.SalesDetail AS sd ON s.SaleID = sd.SaleID
JOIN dbo.Customer AS c ON s.CustomerID = c.CustomerID
JOIN dbo.Product AS p ON sd.ProductID = p.ProductID
GO



                    -----============* ///PORTION 07/// *============-----
-------================================STORE PROCEDURE=============================---------


---==>INSERT PROCEDURE WITH INPUT PARAMETER

CREATE PROC sp_Customer_Insert
    @Name NVARCHAR(100),
    @Phone VARCHAR(15),
    @Email NVARCHAR(100),
    @Address NVARCHAR(225),
    @RegistrationDate DATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customer WHERE Phone = @Phone)
    BEGIN
        RAISERROR ('The phone number already exists. Please use a different phone number.', 11, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Customer WHERE Email = @Email)
    BEGIN
        RAISERROR ('The email address already exists. Please use a different email address.', 20, 1);
        RETURN;
    END

    INSERT INTO Customer (Name, Phone, Email, Address, RegistrationDate)
    VALUES (@Name, @Phone, @Email, @Address, @RegistrationDate);

    PRINT 'Customer inserted successfully.';
END;
GO



---==>UPDATE PROCEDURE WITH INPUT PARAMETER

CREATE PROC sp_Customer_Update
    @CustomerID INT,
    @Name NVARCHAR(100),
    @Phone VARCHAR(15),
    @Email NVARCHAR(100),
    @Address NVARCHAR(225),
    @RegistrationDate DATE
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR ('Customer with the specified ID does not exist.', 16, 1);
        RETURN;
    END

    UPDATE Customer
    SET Name = @Name, Phone = @Phone, Email = @Email, Address = @Address, RegistrationDate = @RegistrationDate
    WHERE CustomerID = @CustomerID;

    PRINT 'Customer updated successfully.';
END;
GO



---==>DELETE PROCEDURE WITH INPUT PARAMETER

CREATE PROC sp_Customer_Delete
    @CustomerID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR ('Customer with the specified ID does not exist.', 16, 1);
        RETURN;
    END

    DELETE FROM Customer
    WHERE CustomerID = @CustomerID;

    PRINT 'Customer deleted successfully.';
END;
GO





                        -----============*///PORTION 08///*============-----
-------===========================TRIGGER (AFTER/FOR TRIGGER)==========================---------


---==>AFTER/FOR INSERT TRIGGER

CREATE TRIGGER tr_Product_Insert
ON Product
AFTER INSERT
AS
BEGIN
	Insert Into ProductAudit
	SELECT 'A new Product is inserted with Id' + CAST(ProductID AS VARCHAR(MAX)), GETDATE()
	FROM inserted;
END;
GO


---==>AFTER/FOR UPDATE TRIGGER

CREATE TRIGGER tr_Product_Update
ON Product
AFTER UPDATE
AS
BEGIN
    INSERT INTO ProductAudit
    SELECT 
        'A product has been updated with ID: ' + CAST(i.ProductID AS VARCHAR(MAX))
        + CASE WHEN i.ProductName != d.ProductName THEN 
            ', product name changed from "' + d.ProductName + '" to "' + i.ProductName + '"' 
            ELSE '' END
        + CASE WHEN i.CategoryID != d.CategoryID THEN 
            ', category ID changed from ' + CAST(d.CategoryID AS VARCHAR(MAX)) + ' to ' + CAST(i.CategoryID AS VARCHAR(MAX)) 
            ELSE '' END
        + CASE WHEN i.ProductPrice != d.ProductPrice THEN 
            ', product price changed from ' + CAST(d.ProductPrice AS VARCHAR(20)) + ' to ' + CAST(i.ProductPrice AS VARCHAR(20)) 
            ELSE '' END
        + CASE WHEN i.QuantityInStock != d.QuantityInStock THEN 
            ', stock changed from ' + CAST(d.QuantityInStock AS VARCHAR(MAX)) + ' to ' + CAST(i.QuantityInStock AS VARCHAR(MAX)) 
            ELSE '' END,
        GETDATE()
    FROM inserted AS i
    INNER JOIN deleted AS d ON i.ProductID = d.ProductID;
END;
GO



---==>AFTER/FOR DELETE TRIGGER

CREATE TRIGGER tr_Product_Delete
ON Product
AFTER DELETE
AS
BEGIN
	Insert Into ProductAudit
	SELECT 'A Product has been Deleted with Id' + CAST(ProductID AS VARCHAR(MAX)), GETDATE()
	FROM deleted
END;
GO


                        -----============*///PORTION 09///*============-----
-------===========================TRIGGER (INSTEAD OF TRIGGER)==========================---------


--==>INSTED OF INSERT TRIGGER

CREATE TRIGGER tr_Supplier_InsteadOfInsert
ON Supplier
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO SupplierAudit (Action, Details)
    SELECT 'Insert', 'A new supplier was added with the following details: '
           + 'Name: ' + SupplierName 
           + ', Contact Person: ' + COALESCE(ContactPerson, 'N/A') 
           + ', Phone: ' + Phone 
           + ', Email: ' + COALESCE(Email, 'N/A') 
           + ', Address: ' + COALESCE(Address, 'N/A')
    FROM inserted;

    -- Perform the actual insert
    INSERT INTO Supplier (SupplierName, ContactPerson, Phone, Email, Address)
    SELECT SupplierName, ContactPerson, Phone, Email, Address
    FROM inserted;
END;
GO



--==>INSTED OF UPDATE TRIGGER

CREATE TRIGGER tr_Supplier_InsteadOfUpdate
ON Supplier
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO SupplierAudit (Action, Details)
    SELECT 'Update', 'A supplier with ID ' + CAST(i.SupplierID AS NVARCHAR(10)) + ' was updated. '
           + CASE WHEN i.SupplierName != d.SupplierName 
               THEN 'Name changed from ' + d.SupplierName + ' to ' + i.SupplierName + '. ' ELSE '' END
           + CASE WHEN i.ContactPerson != d.ContactPerson 
               THEN 'Contact Person changed from ' + COALESCE(d.ContactPerson, 'N/A') + ' to ' + COALESCE(i.ContactPerson, 'N/A') + '. ' ELSE '' END
           + CASE WHEN i.Phone != d.Phone 
               THEN 'Phone changed from ' + d.Phone + ' to ' + i.Phone + '. ' ELSE '' END
           + CASE WHEN i.Email != d.Email 
               THEN 'Email changed from ' + COALESCE(d.Email, 'N/A') + ' to ' + COALESCE(i.Email, 'N/A') + '. ' ELSE '' END
           + CASE WHEN i.Address != d.Address 
               THEN 'Address changed from ' + COALESCE(d.Address, 'N/A') + ' to ' + COALESCE(i.Address, 'N/A') + '. ' ELSE '' END
    FROM inserted i
    INNER JOIN deleted d ON i.SupplierID = d.SupplierID;

    UPDATE Supplier
    SET SupplierName = i.SupplierName,
        ContactPerson = i.ContactPerson,
        Phone = i.Phone,
        Email = i.Email,
        Address = i.Address
    FROM Supplier s
    INNER JOIN inserted i ON s.SupplierID = i.SupplierID;
END;
GO



--==>INSTED OF DELETE TRIGGER

CREATE TRIGGER tr_Supplier_InsteadOfDelete
ON Supplier
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO SupplierAudit (Action, Details)
    SELECT 'Delete', 'A supplier with ID ' + CAST(d.SupplierID AS NVARCHAR(10)) 
           + ', Name: ' + d.SupplierName 
           + ', Phone: ' + d.Phone 
           + ', Email: ' + COALESCE(d.Email, 'N/A') 
           + ', Address: ' + COALESCE(d.Address, 'N/A') + ' was deleted.'
    FROM deleted d;

    DELETE FROM Supplier
    WHERE SupplierID IN (SELECT SupplierID FROM deleted);
END;
GO



                    -----============* ///PORTION 10/// *============-----
-------================================== Functions ==============================---------



--==>Scalar Function

CREATE FUNCTION fn_GetTotalSalesForDay (@SaleDate DATE)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(10, 2);

    SELECT 
        @TotalSales = ISNULL(SUM(sd.Quantity * sd.Price), 0)
    FROM 
        Sales AS s
    INNER JOIN 
        SalesDetail AS sd ON s.SaleID = sd.SaleID
    WHERE 
        CAST(s.SaleDate AS DATE) = @SaleDate;

    RETURN @TotalSales;
END;
GO


--==>Table Valued Function

CREATE FUNCTION fn_GetProductDetailsByProductID (@ProductID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        pc.CategoryName,
        p.ProductName,
        p.ProductPrice,
        p.QuantityInStock,
        s.SupplierName,
        s.ContactPerson,
        s.Phone,
        s.Address,
        pd.PurchaseDate,
        pdDetails.Quantity AS PurchaseQuantity,
        pdDetails.PurchasePrice,
        pd.TotalAmount
    FROM 
        Product AS p
    INNER JOIN 
        ProductCategory AS pc ON p.CategoryID = pc.CategoryID
    INNER JOIN 
        ProductSupplier AS ps ON p.ProductID = ps.ProductID
    INNER JOIN 
        Supplier AS s ON ps.SupplierID = s.SupplierID
    LEFT JOIN 
        Purchase AS pd ON s.SupplierID = pd.SupplierID
    LEFT JOIN 
        PurchaseDetail AS pdDetails ON pd.PurchaseID = pdDetails.PurchaseID AND pdDetails.ProductID = p.ProductID
    WHERE 
        p.ProductID = @ProductID
);
GO





--==>Multi-Statement Function

CREATE FUNCTION fn_GetSalesDetailsForDay (@SaleDate DATE)
RETURNS @SalesDetails TABLE (
    SaleID INT,
    CustomerName NVARCHAR(100),
    ProductName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    TotalSaleAmount DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO @SalesDetails
    SELECT 
        s.SaleID,
        c.Name AS CustomerName,
        p.ProductName,
        sd.Quantity,
        sd.Price,
        (sd.Quantity * sd.Price) AS TotalSaleAmount
    FROM 
        Sales AS s
    INNER JOIN 
        Customer AS c ON s.CustomerID = c.CustomerID
    INNER JOIN 
        SalesDetail AS sd ON s.SaleID = sd.SaleID
    INNER JOIN 
        Product AS p ON sd.ProductID = p.ProductID
    WHERE 
        CAST(s.SaleDate AS DATE) = @SaleDate;

    RETURN;
END;
GO
-------------------------------------------------*******************************---------------------------------------------------------