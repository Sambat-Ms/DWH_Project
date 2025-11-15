-------------CREATE WH_DATABASE
DROP DATABASE IF EXISTS AdventureWorks_DWH_Sambat;
CREATE DATABASE AdventureWorks_DWH_Sambat;


-----------CREATE FACT TABLES
DROP TABLE IF EXISTS FactOnlineSales
GO
CREATE TABLE FactOnlineSales(
 Load_Date					DATETIME
, CarrierTrackingNumber		NVARCHAR(25)
, OrderQuantity				SMALLINT
, ProductSK						INT
, CustomerSK					INT
, SalesOrderLineNumber			INT
, PromotionSK					INT
, DiscountAmount				MONEY
, CurrencySK					INT
, DueDate						DATETIME
, Freight						MONEY
, OrderDate						DATETIME
, PurchaseOrderNumber   NVARCHAR(25)
,RevisionNumber				NVARCHAR(25)
, SalesOrderNumber			NVARCHAR(25)
, ShipDate						DATETIME
, SalesAmount					MONEY
, TaxAmt							MONEY
, ProductID              INT NOT NULL
,PromotionID           INT NOT NULL
, CustomerID			INT NOT NULL
,SalesTerritoryID		    INT NOT NULL
,CurrencyCode			NCHAR(3)		
,CurrencyRateDate     DATETIME          -- or DATETIME if time is needed
,AverageRate          DECIMAL(18, 6) -- precise decimal for currency rates
,EndOfDayRate         DECIMAL(18, 6)  -- same precision for consistency
, SalesTerritorySK			INT
 -- Date surrogate keys (new columns)
   , OrderDateKey            INT       -- e.g. 20250101
   , ShipDateKey             INT
   , DueDateKey              INT
);


DROP TABLE IF EXISTS FactStoreSales
GO
CREATE TABLE FactStoreSales
(
    -- Audit / Load info
    Load_Date               DATETIME,

    -- Business columns
    CarrierTrackingNumber   NVARCHAR(25),
    OrderQuantity           SMALLINT,
    ProductSK               INT,
    SalesOrderLineNumber    INT,
    PromotionSK             INT,
    DiscountAmount          MONEY,
    CurrencySK              INT,
	CustomerSK				INT,
	StoreSK                 INT,

    -- Date surrogate keys (new columns)
    OrderDateKey            INT,       -- e.g. 20250101
    ShipDateKey             INT,
    DueDateKey              INT,

    -- Original date columns
    DueDate                 DATETIME,
    Freight                 MONEY,
    OrderDate               DATETIME,
    PurchaseOrderNumber  NVARCHAR(25),
    RevisionNumber          NVARCHAR(25),
    SalesOrderNumber        NVARCHAR(25),
    SalesPersonID           INT,
    ShipDate                DATETIME,
    SalesAmount             MONEY,
    TaxAmt                  MONEY,

    -- Dimension foreign keys
    ProductID               INT NOT NULL,
    PromotionID             INT NOT NULL,
    SalesTerritoryID        INT NOT NULL,
    CurrencyCode            NCHAR(3),
--------Add more Dimension foreign 
	StoreAK     INT NOT NULL,
	CustomerID  INT NOT NULL,
    -- Currency info
    CurrencyRateDate        DATETIME,
    AverageRate             DECIMAL(18,6),
    EndOfDayRate            DECIMAL(18,6),

    SalesTerritorySK        INT
);
-----------------------------------------------------------
------------------------Dimmension Tables

DROP TABLE IF EXISTS DimStore
GO
CREATE TABLE DimStore
( StoreSK				INT				IDENTITY(1,1) PRIMARY KEY
,StoreAK	 INT  
 ,AnnualRevenue			DECIMAL(19,4)
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
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
);


DROP TABLE IF EXISTS DimSalesTerritory
GO
CREATE TABLE DimSalesTerritory
(
  SalesTerritorySK			INT				IDENTITY(1,1) PRIMARY KEY
, CountryRegionCode		    NVARCHAR(3)
, SalesTerritoryGroup	    NVARCHAR(50)
, SalesTerritoryName		NVARCHAR(50)
, SalesTerritoryID		    INT NOT NULL
, SalesYTD					MONEY
, SalesLastYear			    MONEY
, CostYTD					MONEY
, CostLastYear				MONEY
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)

DROP TABLE IF EXISTS DimPromotion
GO
CREATE TABLE DimPromotion
(PromotionSK				INT	 IDENTITY(1,1)			PRIMARY KEY
, PromotionID				INT NOT NULL UNIQUE
, PromotionCategory		NVARCHAR(50)
, PromotionName			NVARCHAR(255)
, PromotionDiscountPct	SMALLMONEY
, PromotionEndDate		DATETIME
, PromotionMaxQty			INT
, PromotionMinQty			INT
, PromotionStartDate		DATETIME
, PromotionType			NVARCHAR(50)
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)


DROP TABLE IF EXISTS DimCurrency
GO
CREATE TABLE DimCurrency
(
CurrencySK				INT				IDENTITY(1,1) PRIMARY KEY
,CurrencyCode			NCHAR(3)		NOT NULL
,CurrencyName			NVARCHAR(100)		NOT NULL
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)

DROP TABLE IF EXISTS DimProduct
GO
CREATE TABLE DimProduct
(
ProductSK						INT				IDENTITY(1,1) PRIMARY KEY	
, ProductID						INT NOT NULL UNIQUE		
, ProductClass					NCHAR(2)		
, ProductColor					NVARCHAR(15)	
, DaysToManufacture			INT				
, DiscontinuedDate			DATETIME		
, FinishedGoodsFlag			BIT				
, ListPrice						MONEY			
, MakeFlag						BIT				
, ProductName					NVARCHAR(50)	
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
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)


DROP TABLE IF EXISTS DimDate
GO
CREATE TABLE dbo.DimDate (
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


DROP TABLE IF EXISTS DimCustomer
GO
CREATE TABLE DimCustomer
(
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
, CustomerSK				INT					IDENTITY(1,1) PRIMARY KEY
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
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)


