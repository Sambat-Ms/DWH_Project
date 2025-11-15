----CREATE vw_DimCustomer USE AdventureWorks2019;
USE AdventureWorks2019;
GO

DROP VIEW IF EXISTS dbo.vw_DimCustomer;
GO
CREATE VIEW dbo.vw_DimCustomer
AS
SELECT 
    c.CustomerID,
    c.StoreID,
    c.TerritoryID,
    pp.PhoneNumber AS Phone,
    p.Title,
    p.Suffix,
    p.NameStyle,
    p.FirstName,
    p.MiddleName,
    p.LastName,
    eam.EmailAddress,
    pd.BirthDate,
    pd.DateFirstPurchase,
    pd.Education,
    pd.Gender,
    pd.HomeOwnerFlag,
    pd.MaritalStatus,
    pd.NumberCarsOwned,
    pd.NumberChildrenAtHome,
    pd.Occupation,
    pd.TotalChildren,
    pd.YearlyIncome,
    pd.TotalPurchaseYTD
FROM Sales.Customer AS c
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonPhone AS pp
    ON p.BusinessEntityID = pp.BusinessEntityID
LEFT JOIN Person.EmailAddress AS eam
    ON p.BusinessEntityID = eam.BusinessEntityID
LEFT JOIN Sales.vPersonDemographics AS pd
    ON p.BusinessEntityID = pd.BusinessEntityID;
GO



----CREATE vw_DimProduct USE AdventureWorks2019;
USE AdventureWorks2019;
GO

DROP VIEW IF EXISTS dbo.vw_DimProduct;
GO

CREATE VIEW dbo.vw_DimProduct
AS
SELECT 
    p.ProductID,
    p.ProductNumber,
    p.Name AS ProductName,
    p.Color,
	p.Style,
    p.StandardCost,
    p.ListPrice,
	p.MakeFlag,
	p.FinishedGoodsFlag,
	p.DaysToManufacture,
	p.DiscontinuedDate,
	p.WeightUnitMeasureCode,
	p.Class,
	p.ProductModelID,
	p.ProductLine,
	p.ProductSubcategoryID,
	p.ReorderPoint,
	p.SafetyStockLevel,
	p.SizeUnitMeasureCode,
	ps.Name as ProductSubcategoryName,
    pc.ProductCategoryID,
    pc.Name AS CategoryName,
    pm.Name AS ProductModelName,
    p.Size,
    p.Weight,
    p.SellStartDate,
    p.SellEndDate
FROM Production.Product AS p
LEFT JOIN Production.ProductSubcategory AS ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
LEFT JOIN Production.ProductModel AS pm
    ON p.ProductModelID = pm.ProductModelID;
GO



----CREATE vw_DimStore USE AdventureWorks2019;
SELECT vs.*, s.SalesPersonID,s.BusinessEntityID as StoreAK
FROM [Sales].[vStoreWithDemographics] vs
LEFT JOIN [Sales].[Store] s
ON vs.BusinessEntityID = s.BusinessEntityID





-------- Create Views for FactOnlineSale & FactStoreSales

----CREATE vw_FactStoreSales USE AdventureWorks2019;
DROP VIEW IF EXISTS dbo.vw_FactStoreSales;
GO

CREATE VIEW dbo.vw_FactStoreSales
AS
SELECT 

    soh.OrderDate,
    soh.DueDate,
    soh.Freight,
    soh.PurchaseOrderNumber,
    soh.RevisionNumber,
    soh.SalesOrderNumber,
    soh.SalesPersonID,
    soh.ShipDate,
    soh.SubTotal,
    soh.TaxAmt,
	soh.TerritoryID,
	soh.CustomerID,
    scr.CurrencyRateDate,
    scr.AverageRate,
    scr.EndOfDayRate,
	scr.ToCurrencyCode,
    sod.CarrierTrackingNumber,
    sod.OrderQty,
    sod.SalesOrderDetailID,
    sod.UnitPriceDiscount,
	sod.ProductID,
	sod.SpecialOfferID,
	sc.StoreID As StoreAK  
FROM [Sales].[SalesOrderHeader] AS soh
INNER JOIN [Sales].[SalesOrderDetail] AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN [Sales].[CurrencyRate] AS scr
    ON soh.CurrencyRateID = scr.CurrencyRateID
LEFT JOIN Sales.Customer sc
ON soh.CustomerID = sc.CustomerID 
WHERE soh.OnlineOrderFlag = 0;
GO

----CREATE vw_FFactOnlineSales USE AdventureWorks2019;

DROP VIEW IF EXISTS dbo.vw_FactOnlineSales;
GO

CREATE VIEW dbo.vw_FactOnlineSales
AS
SELECT 
    soh.OrderDate,
    soh.DueDate,
    soh.Freight,
    soh.PurchaseOrderNumber,
    soh.RevisionNumber,
    soh.SalesOrderNumber,
    soh.ShipDate,
    soh.SubTotal,
    soh.TaxAmt,
	soh.TerritoryID,
	soh.CustomerID,
    scr.CurrencyRateDate,
    scr.AverageRate,
    scr.EndOfDayRate,
	scr.ToCurrencyCode,
    sod.CarrierTrackingNumber,
    sod.OrderQty,
    sod.SalesOrderDetailID,
    sod.UnitPriceDiscount,
	sod.ProductID,
	sod.SpecialOfferID
FROM [Sales].[SalesOrderHeader] AS soh
INNER JOIN [Sales].[SalesOrderDetail] AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN [Sales].[CurrencyRate] AS scr
    ON soh.CurrencyRateID = scr.CurrencyRateID
WHERE soh.OnlineOrderFlag = 1;
GO


---------\\\\\\\\Create PROCEDURE Dimdate\\\\\\\
USE [AdventureWorks_DWH_Sambat];
GO

CREATE OR ALTER PROCEDURE dbo.usp_PopulateDimDateAuto
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @StartDate DATE,
        @EndDate DATE,
        @CurrentDate DATE;

    --  Get min and max dates from AdventureWorks2019
    SELECT 
        @StartDate = MIN(OrderDate),
        @EndDate = MAX(DueDate)
    FROM AdventureWorks2019.Sales.SalesOrderHeader;

    -- Safety check if dates are null
    IF @StartDate IS NULL OR @EndDate IS NULL
    BEGIN
        RAISERROR('No date range found in SalesOrderHeader.', 16, 1);
        RETURN;
    END

    SET @CurrentDate = @StartDate;

    PRINT 'Populating DimDate from ' + CONVERT(VARCHAR(10), @StartDate, 120) + 
          ' to ' + CONVERT(VARCHAR(10), @EndDate, 120);

    -- Optional: Clear existing data
    TRUNCATE TABLE dbo.DimDate;

    -- Loop through each date
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO dbo.DimDate (
            DateKey,
            FullDate,
            DayNumberOfWeek,
            DayNameOfWeek,
            DayNameOfWeekAbbr,
            DayNumberOfMonth,
            DayNumberOfYear,
            WeekNumberOfYear,
            MonthName,
            MonthNameAbbr,
            MonthNumberOfYear,
            CalendarQuarter,
            CalendarYear,
            CreationDate,
            ModificationDate
        )
        SELECT
            CONVERT(INT, FORMAT(@CurrentDate, 'yyyyMMdd')) AS DateKey,
            @CurrentDate AS FullDate,
            DATEPART(WEEKDAY, @CurrentDate) AS DayNumberOfWeek,
            DATENAME(WEEKDAY, @CurrentDate) AS DayNameOfWeek,
            LEFT(DATENAME(WEEKDAY, @CurrentDate), 3) AS DayNameOfWeekAbbr,
            DAY(@CurrentDate) AS DayNumberOfMonth,
            DATEPART(DAYOFYEAR, @CurrentDate) AS DayNumberOfYear,
            DATEPART(WEEK, @CurrentDate) AS WeekNumberOfYear,
            DATENAME(MONTH, @CurrentDate) AS MonthName,
            LEFT(DATENAME(MONTH, @CurrentDate), 3) AS MonthNameAbbr,
            MONTH(@CurrentDate) AS MonthNumberOfYear,
            DATEPART(QUARTER, @CurrentDate) AS CalendarQuarter,
            YEAR(@CurrentDate) AS CalendarYear,
            GETDATE() AS CreationDate,
            GETDATE() AS ModificationDate;

        --  Move to next day
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END

    PRINT ' DimDate populated successfully!';
END;
GO

EXEC [dbo].[usp_PopulateDimDateAuto]

