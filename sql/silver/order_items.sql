DROP TABLE IF EXISTS silver.order_items;

CREATE TABLE silver.order_items AS
SELECT DISTINCT
	TRIM(oi.order_id)as order_id,
	oi.product_id,
	oi.price,
	oi.freight_value
FROM bronze.order_items as oi
JOIN silver.orders as o
	ON TRIM(oi.order_id) = TRIM(o.order_id)
WHERE oi.price >= 0;