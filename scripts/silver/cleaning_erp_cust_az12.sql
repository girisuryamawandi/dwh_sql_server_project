TRUNCATE 
TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12 (
		cid,
		bdate,
		gen
)
SELECT
	CASE WHEN cid like 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) -- remove NAS suffix if present
		 ELSE cid
	END cid,
	CASE WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END bdate, -- set future birthday is NULL
	CASE WHEN UPPER(TRIM(gen)) in ('F','FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen)) in ('M','MALE') THEN 'Male'
		 ELSE 'n/a'
	END gen -- Normalize gender valuees and handle unkown cases

FROM
	bronze.erp_cust_az12;
