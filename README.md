# DWH_Project
Data Warehouse implementation with ETL pipelines and dimensional modeling and business intelligence solutions
## Project Overview
  The scope of this project covers the end-to-end design and implementation of a Sales Data Warehouse(AdventureWorks_DWH) for Adventure Works Cycles. The focus is to transform the company’s existing transactional data into a structured analytical environment that supports strategic reporting and businessintelligence. 
### Architecture
1. Warehouse architecture design  
The solution follows Two_tire architecture, a typical three-layer data warehouse architecture which includes Source Contains 
- The AdventureWorks2019 transactional database 
- Staging Database 
- Data Warehouse 
2. Data Modelimg design
  
Data model is designed using a Galaxy Schema approach contain two fact table are Fact StoreSale and Onlinesale, 
seven dimension table like Dim_Product, Dim_Promotion, Dim_Store, Dim_SaleTerritory, Dim_Date, Dim_Customer, Dim_Currency. 
For Dim_Store is not connect to Fact OnlineSales. 

3. ETL Pipeline (Daily incremental data loading)
- A [AdventureWork Source DB] ---> B [ETL_Extract] 
- B ---> C [Staging Area] 
- C ---> D [ETL_Tranformation] 
- D ---> E [Data Warehouse] 
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
1. Clone repository:
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



