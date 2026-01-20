DROP TABLE IF EXISTS silver.products;

CREATE TABLE silver.products AS
SELECT DISTINCT 
	product_id,
	product_category
FROM bronze.products
WHERE product_id IS NOT NULL;