/*
==============================================================================================================================================================
CREATE DATABASE AND SCHEMAS
=============================================================================================================================================================
SCRIPTS PURPOSE:
    This scripts creates a new database named 'Datawarehouse' after checking if it already exists.
    if the database exists. it dropped and recreated. Additionaly , the script sets up up three schemas
    within the database: 'bronze', 'silver' , and 'gold'.
WARNING
    Running this script will drop the entire 'Datawarehouse' databaseif it exists.
    All data in the dataset will be permannetly deleted. proceed with caution
    and ensure you have proper backups beforebefore running the scripts.
*/




USE MASTER;
GO

USE Datawarehouse;
GO

--	Drop and recreate the'Datawarehouse database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;
GO


USE Datawarehouse;
GO


--create  schema
CREATE SCHEMA bronze;
GO
CREATE SCHEMA gold;
GO
CREATE SCHEMA silver;
GO
