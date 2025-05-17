/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This Script for creating database with name DataWareHouse and Shcema for each layer bronze, silver and Gold. If the database DataWareHouse is existing, then This Script will drop the 
    database and recreate new one
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
    Ensure to backup data before using it. 
*/

USE master;
Go

-- Drop and recreate the datawarehouse

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN 
	ALTER DATABASE DataWareHouse 
	SET SINGLE_USER 
	WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

CREATE DATABASE	DataWareHouse;
GO

USE DataWareHouse;
GO

-- Create Schema
CREATE SCHEMA bronze;
Go

CREATE SCHEMA silver;

Go
CREATE SCHEMA gold;
