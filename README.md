# 📊 DWH_Project

Data Warehouse Implementation with ETL Pipelines, Dimensional Modeling, and Business Intelligence

# 📌 Project Overview

This project presents the end-to-end design and implementation of a Sales Data Warehouse (AdventureWorks_DWH) for Adventure Works Cycles.

The goal is to transform raw transactional data into a structured analytical system that supports strategic reporting, dashboards, and business intelligence insights.

# 🏗️ Architecture

**1. Data Warehouse Architecture Design**

The solution follows a three-tier data warehouse architecture:

- **Source Layer:**
AdventureWorks2019 transactional database
- **Staging Layer:**
Intermediate data storage for cleaning and transformation
- **Data Warehouse Layer:**
Final structured analytical database for reporting and BI
  
**2. Data Modeling Design**

The data model is designed using a Galaxy Schema (Fact Constellation) approach.

**Fact Tables:**
- Fact_Sales
- Fact_OnlineSales
**Dimension Tables:**
- Dim_Product
- Dim_Promotion
- Dim_Store
- Dim_SalesTerritory
- Dim_Date
- Dim_Customer
- Dim_Currency
**📌 Note: Dim_Store is not connected to Fact_OnlineSales due to business logic separation.**

**3. ETL Pipeline (Daily Incremental Load)**

The ETL process follows a structured pipeline:

```
AdventureWorks Source DB
        ↓
ETL Extract
        ↓
Staging Area
        ↓
ETL Transformation
        ↓
Data Warehouse
```
  
#### Technologies used 
- Database [Microsoft SQL Server] 
- ETL [SSIS Packages]
- Development [SSMS, Visual Studio]
- Source Data [AdventureWork2019] 
##### Bussiness Questions
1. Which products are the most profitable over time?
2. How are sales trends performing across different regions and channels?
3. Which customers contribute most to revenue growth?
###### Installation & Setup
- Prerequisites
1. SQL SERVER DATABASE: Use to store and process data pipeline and deploy ETL pipeline that
was created in SQL SERVER INTEGRATION SERVICE.
2. VISUAL STUDIO & SSIS: Use to develop ETL pipeline for building data warehouse project.
3. AdventureWorks sample database
4. python exe : use to run ETL message alert to TelegramBot  
- Step-by-Step Setup
1. Clone repository:https://github.com/Sambat-Ms/DWH_Project.git 
2. Restore AdventureWorks database
3. Execute DDL scripts in order
- DB_Script_stanging.sql
- DWH_DDL Script.sql
- Script Create View for Join Tables and Procedure_DimDate.sql
4. Run ETL packages through SSIS 
  - Deploy the project to Integration Service Catalog (SSISDB) on the SQL Server instance
  - Confirm that all connection managers, parameters, and environment configurations are correctly set in the SSIS catalog
  - Validate the deployed packages to ensure they run successfully on the server
  - Create a new job to automate the execution of the deployed SSIS packages



