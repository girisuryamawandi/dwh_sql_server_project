/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_batch DATETIME, @end_batch DATETIME
	BEGIN TRY
		SET @start_batch = GETDATE();
		PRINT '============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================================================';


		PRINT '------------------------------------------------------------';
		PRINT 'Loading CRM Table';
		PRINT '------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Insert Into : bronze.crm_cust_info'
		BULK insert bronze.crm_cust_info
		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_crm\cust_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '---------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Insert Into : bronze.crm_prd_info'
		BULK insert bronze.crm_prd_info
		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_crm\prd_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '---------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Insert Into : bronze.crm_sales_details'
		BULK insert bronze.crm_sales_details
		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_crm\sales_details.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '---------------------'


		PRINT '------------------------------------------------------------';
		PRINT 'Loading ERP Table';
		PRINT '------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Insert Into : bronze.erp_cust_az12'
		BULK insert bronze.erp_cust_az12

		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_erp\cust_az12.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '---------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Insert Into : bronze.erp_loc_a101'
		BULK insert bronze.erp_loc_a101
		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_erp\loc_a101.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '---------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Insert Into : bronze.erp_px_cat_g1v2'
		BULK insert bronze.erp_px_cat_g1v2
		FROM 'E:\latihan\SQL\datawarehouse\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_batch = GETDATE();
		PRINT '====================================================================';
		PRINT 'Loading Bronze Layer Is Completed'
		PRINT '		--Total LOAD DURATION : ' + CAST(DATEDIFF(second, @start_batch, @end_batch) AS NVARCHAR) + ' seconds'
		PRINT '====================================================================';
	END TRY

	BEGIN CATCH
		PRINT '====================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '====================================================================';
	END CATCH

END