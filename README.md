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
  
# ⚙️ Technologies Used
- **Database:** Microsoft SQL Server
- **ETL Tool:** SQL Server Integration Services (SSIS)
- **Development Tools:** SQL Server Management Studio (SSMS), Visual Studio
- **Source Data:** AdventureWorks2019
- **Automation:** Python (Telegram Bot alerts for ETL monitoring)
  
# 📈 Business Questions

**This data warehouse is designed to answer key business questions:**

1. Which products are the most profitable over time?
2. How do sales trends vary across regions and sales channels?
3. Which customers generate the highest revenue contribution?
   
# 🛠️ Installation & Setup
**Prerequisites:**
- **SQL Server Database**
    - Used for storing and processing data pipelines
    - Required for SSIS execution
- **Visual Studio + SSIS:**
    - Used to develop ETL packages
- **AdventureWorks Sample Database**
    - Source system for transactional data
- **Python (optional)**
    - Used for ETL monitoring and Telegram bot notifications

**Step-by-Step Setup**

1. **Clone the repository:**
git clone https://github.com/Sambat-Ms/DWH_Project.git

2. **Restore the AdventureWorks database in SQL Server**
   
3. ** Run SQL scripts in order:**
- DB_Script_staging.sql
- DWH_DDL_Script.sql
- Create_Views_And_StoredProcedures.sql
  
4. **Deploy and run ETL packages:**
- Deploy SSIS project to SSISDB (Integration Services Catalog)
- Verify all connection managers and parameters
- Validate package execution on SQL Server
- Create a SQL Server Agent Job to automate ETL execution



