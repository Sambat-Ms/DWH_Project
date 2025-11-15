--------------------CREATE STAGING_DATABASE 
DROP DATABASE IF EXISTS DWH_DB_Staging;
CREATE DATABASE DWH_DB_Staging;


-- =============================================
-- Create Staging_SalesTerritory Table
-- =============================================
DROP TABLE IF EXISTS Staging_SalesTerritory
GO
CREATE TABLE  Staging_SalesTerritory (
 CountryRegionCode		    NVARCHAR(3)
, SalesTerritoryGroup	    NVARCHAR(50)
, SalesTerritoryName		NVARCHAR(50)
, SalesTerritoryID		    INT NOT NULL
, SalesYTD					MONEY
, SalesLastYear			    MONEY
, CostYTD					MONEY
, CostLastYear				MONEY
);
GO

PRINT 'Staging_SalesTerritory table created successfully.';
GO

-- =============================================
-- Create Staging_Cusomer Table
-- =============================================
DROP TABLE IF EXISTS Staging_Customer
GO
CREATE TABLE Staging_Customer (
     BirthDate					DATE
, DateFirstPurchase		DATE
, Education					NVARCHAR(30)
, Gender						NVARCHAR(1)
, HomeOwnerFlag			BIT
, MaritalStatus			NVARCHAR(1)
, NumberCarsOwned			INT
, NumberChildrenAtHome	INT
, Occupation				NVARCHAR(30)
, TotalChildren			INT
, YearlyIncome				NVARCHAR(30)
, TotalPurchaseYTD		MONEY
, EmailAddress				NVARCHAR(50)
, FirstName					NVARCHAR(50)
, LastName					NVARCHAR(50)
, MiddleName				NVARCHAR(50)
, NameStyle					BIT
, Suffix						NVARCHAR(10)
, Title						NVARCHAR(8)
, Phone						NVARCHAR(25)
, TerritoryID				INT
, StoreID					INT
, CustomerID				INT

);
GO

PRINT 'Staging_Customer table created successfully.';
GO

-- =============================================
-- Create Staging_Product Table
-- =============================================
DROP TABLE IF EXISTS Staging_Product
GO
CREATE TABLE Staging_Product (		
 ProductClass					NCHAR(2)		
, ProductColor					NVARCHAR(15)	
, DaysToManufacture			INT				
, DiscontinuedDate			DATETIME		
, FinishedGoodsFlag			BIT				
, ListPrice						MONEY			
, MakeFlag						BIT				
, ProductName					NVARCHAR(50)	
, ProductID						INT				
, ProductLine					NCHAR(2)		
, ProductModelID				INT				
, ProductNumber				NVARCHAR(25)	
, ProductSubcategoryID		INT				
, ReorderPoint					SMALLINT		
, SafetyStockLevel			SMALLINT		
, SellEndDate					DATETIME		
, SellStartDate				DATETIME		
, ProductSize					NVARCHAR(5)		
, SizeUnitMeasureCode		NCHAR(3)		
, StandardCost					MONEY			
, ProductStyle					NCHAR(2)		
, ProductWeight				DECIMAL(8,2)	
, WeightUnitMeasureCode		NCHAR(3)		
, ProductCategoryName		NVARCHAR(50)	
, ProductCategoryID			INT				
, ModelName						NVARCHAR(50)	
, ProductSubcategoryName	NVARCHAR(50)
);
GO

PRINT 'Staging_Product table created successfully.';
GO

	-- Create Staging_Currecy Table
-- =============================================
DROP TABLE IF EXISTS Staging_Currency
GO
CREATE TABLE Staging_Currency (
 CurrencyCode			NCHAR(3)		NOT NULL
,CurrencyName			NVARCHAR(100)		NOT NULL

);
GO

PRINT 'Staging_Currency created successfully.';
GO

	-- Create Staging_Promotion Table
-- =============================================
DROP TABLE IF EXISTS Staging_Promotion
GO
CREATE TABLE Staging_Promotion (
   PromotionCategory		NVARCHAR(50)
, PromotionName			NVARCHAR(255)
, PromotionDiscountPct	SMALLMONEY
, PromotionEndDate		DATETIME
, PromotionMaxQty			INT
, PromotionMinQty			INT
, PromotionStartDate		DATETIME
, PromotionType			NVARCHAR(50)
, PromotionID				INT UNIQUE

);
GO

PRINT 'Staging_Promotion table created successfully.';
GO

	-- Create Staging_Store Table
-- =============================================
DROP TABLE IF EXISTS Staging_Store
GO
CREATE TABLE Staging_Store (
   AnnualRevenue			DECIMAL(19,4)
, AnnualSales			DECIMAL(19,4)
, BankName				NVARCHAR(50)
, Brands					NVARCHAR(30)
, BusinessType			NVARCHAR(5)
, Internet				NVARCHAR(30)
, BusinessName			NVARCHAR(50)
, NumberEmployees		INT
, SalesPersonID		INT
, Specialty				NVARCHAR(50)
, SquareFeet			INT
, YearOpened			INT
,StoreAK	 INT  

);
GO

PRINT 'Staging_Store table created successfully.';
GO


	-- Create Staging_Date Table
-- =============================================
DROP TABLE IF EXISTS dbo.Stg_DimDate
GO
CREATE TABLE dbo.Stg_DimDate (
    DateKey INT PRIMARY KEY NOT NULL,
    FullDate DATE NOT NULL,
    DayNumberOfWeek TINYINT,
    DayNameOfWeek NVARCHAR(20),
    DayNameOfWeekAbbr NVARCHAR(3),
    DayNumberOfMonth TINYINT,
    DayNumberOfYear SMALLINT,
    WeekNumberOfYear TINYINT,
    MonthName NVARCHAR(20),
    MonthNameAbbr NVARCHAR(3),
    MonthNumberOfYear TINYINT,
    CalendarQuarter TINYINT,
    CalendarYear SMALLINT,
    CreationDate DATETIME DEFAULT GETDATE(),
    ModificationDate DATETIME DEFAULT GETDATE()
);


GO

PRINT 'dbo.Stg_DimDate table created successfully.';
GO

	-- Create Staging_FactStoreSales Table
-- =============================================
DROP TABLE IF EXISTS Staging_FactStoreSale
GO
CREATE TABLE Staging_FactStoreSale (
 CarrierTrackingNumber		NVARCHAR(25)
, OrderQuantity				SMALLINT
, SalesOrderLineNumber			INT
,RevisionNumber				NVARCHAR(25)
, DiscountAmount				MONEY
, DueDate						DATETIME
, Freight						MONEY
, OrderDate						DATETIME
, PurchaseOrderNumber		NVARCHAR(25)
, SalesOrderNumber			NVARCHAR(25)
, SalesPersonID				INT 
, ShipDate						DATETIME
, SalesAmount					MONEY
,TaxAmt						    MONEY 
, ProductID              INT NOT NULL
,PromotionID           INT NOT NULL
,SalesTerritoryID		    INT NOT NULL
,CurrencyCode			NCHAR(3)	
,StoreAK     INT NOT NULL
,CustomerID  INT NOT NULL
,CurrencyRateDate     DATETIME          -- or DATETIME if time is needed
,AverageRate          DECIMAL(18, 6) -- precise decimal for currency rates
,EndOfDayRate         DECIMAL(18, 6)
);
GO 

PRINT 'Staging_FactStoreSale table created successfully.';
GO

-- Create Staging_FactOnlineSales Table
-- =============================================
DROP TABLE IF EXISTS Staging_FactOnlineSales
GO
CREATE TABLE Staging_FactOnlineSales (
 CarrierTrackingNumber		NVARCHAR(25)
, OrderQuantity				SMALLINT
, SalesOrderLineNumber			INT
,RevisionNumber				NVARCHAR(25)
, DiscountAmount				MONEY
, DueDate						DATETIME
, Freight						MONEY
, OrderDate						DATETIME
, PurchaseOrderNumber		NVARCHAR(25)
, SalesOrderNumber			NVARCHAR(25)
, ShipDate						DATETIME
, SalesAmount					MONEY
,TaxAmt						    MONEY 
,ProductID              INT NOT NULL
,PromotionID           INT NOT NULL
, CustomerID			INT NOT NULL
,SalesTerritoryID		    INT NOT NULL
,CurrencyCode			NCHAR(3)		
,CurrencyRateDate     DATETIME          -- or DATETIME if time is needed
,AverageRate          DECIMAL(18, 6) -- precise decimal for currency rates
,EndOfDayRate         DECIMAL(18, 6)
);
GO

PRINT 'Staging_FactOnlineSales table created successfully.';
GO
   
