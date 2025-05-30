TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101 
	(
	cid,
	cntry
	)
SELECT
	REPLACE(cid,'-','') as cid,
	CASE WHEN UPPER(TRIM(cntry)) IN ('USA','US','UNITED STATES') THEN 'United States'
		 WHEN UPPER(TRIM(cntry)) IN ('DE','GERMANY') THEN 'Germany'
		 WHEN UPPER(TRIM(cntry)) IS NULL OR cntry = '' THEN 'n\a'
		 ELSE cntry
	END AS cntry -- Normalize cntry values and handle unkown values
FROM	
	bronze.erp_loc_a101