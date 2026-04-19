/*
===========================
Create Database and Schemas
===========================
Script purpose: 
  This script creates a new database named 'Datawarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script setup three schemas within the database: bronze, silver, gold. 
WARNING: 
  Running this script will drop the entire 'Datawarehouse' database if it exists. 
  All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script. 
*/

USE master;
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;
GO
---Create  the 'Datawarehouse' database
CREATE DATABASE Datawarehouse;
GO

---Create schemas
USE Datawarehouse
GO

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
