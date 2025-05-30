CREATE VIEW gold.dim_products AS
SELECT 
	cpi.prd_id AS product_id,
	cpi.prd_key AS product_key,
	cpi.prd_nm AS product_name,
	cpi.cat_id AS category_id,
	epc.cat AS category,
	epc.subcat AS sub_category,
	epc.maintenance,
	cpi.prd_cost AS cost,
	cpi.prd_line AS production_line,
	cpi.prd_start_dt AS start_date 
FROM
	silver.crm_prd_info cpi
LEFT JOIN silver.erp_px_cat_g1v2 epc
ON cpi.cat_id = epc.id
WHERE cpi.prd_end_dt IS NULL -- filter out old data
