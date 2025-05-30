SELECT DISTINCT
	sls_sales as old_sales,
	sls_price as old_price,
	CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
	END sls_sales,
	sls_quantity,
	CASE
		WHEN sls_price IS NULL OR sls_price = 0 THEN sls_sales / NULLIF(sls_quantity,0)
		WHEN sls_price <= 0 THEN ABS(sls_price)
		ELSE sls_price
	END AS sls_price
FROM
	bronze.crm_sales_details
WHERE 
	sls_sales != sls_price * sls_quantity or sls_sales IS NULL OR sls_price IS NULL OR sls_quantity IS NULL
ORDER BY
	sls_sales, sls_quantity, sls_price
	;
SELECT
	sls_order_dt
FROM
	bronze.crm_sales_details
WHERE LEN(sls_order_dt) > 8 OR LEN(sls_order_dt) < 8
	;

SELECT
	DISTINCT sls_sales,
	count(*)
FROM
	bronze.crm_sales_details
GROUP BY sls_sales
HAVING count(*) > 1
	;
SELECT
	prd_line
FROM
	silver.crm_prd_info
WHERE 
	TRIM(prd_line) != prd_line

