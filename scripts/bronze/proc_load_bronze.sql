/*
========================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
========================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' tables from CSV files.

  It does the following:
  - Clears (truncates) existing data in each bronze table.
  - Loads fresh data from CSV files using BULK INSERT.
  - Processes both CRM and ERP data tables.
  - Shows messages to track progress and load time.
  - Handles errors if anything goes wrong during execution.

Parameters:
  None.

Usage Example:
  EXEC bronze.load_bronze;
========================================================================================
*/=============================*/
This keeps it clean, beginner-friendly, and still accurate to your code.
IF OBJECT_ID('bronze.load_bronze', 'P') IS NOT NULL
    DROP PROCEDURE bronze.load_bronze;
	GO
CREATE PROCEDURE bronze.load_bronze
AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();

		PRINT'=============================================================================================';
		PRINT'LOADING BRONZE LAYER'
		PRINT'=============================================================================================';
	
		PRINT'---------------------------------------------------------------------------------------------';
		PRINT'LOADING CRM TABLE'
		PRINT'---------------------------------------------------------------------------------------------';
	    SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>> INSERTING TABLE: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT'>>--------------------'
		
		SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT'>> INSERTING TABLE: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT'>>--------------------'

		SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT'>> INSERTING TABLE: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT'>>--------------------'

		PRINT('-------------------------------------------------------------------------------------------------------------')
		PRINT('LOADING ERP');
		PRINT('-------------------------------------------------------------------------------------------------------------')
		SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'>> INSERTING TABLE: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT'>>--------------------'

		SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'>> INSERTING TABLE: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT'>>--------------------'

		SET @start_time = GETDATE();
		PRINT'>> TRUNCATING TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT'>> INSERTING TABLE: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Chief Larry Samuel\Desktop\Data Engineering Project\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duartion: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';

		SET @batch_start_time = GETDATE();
		PRINT'=================================================';
		PRINT'loading Brinze Layer is Completed';
		Print' - Total Load Duration: '+ CAST(DATEDIFF(second, @batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT'================================================='
		END TRY
	BEGIN CATCH
	PRINT'============================================================';
	PRINT'ERROR OCCURED DURING PROGRAM EXCEUTION';
	PRINT'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT'============================================================';
	END CATCH
END;
GO


