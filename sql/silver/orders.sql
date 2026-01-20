DROP TABLE IF EXISTS silver.orders;

CREATE TABLE silver.orders AS
SELECT DISTINCT
	order_id,
	customer_id,
	order_purchase_timestamp::DATE AS order_date
FROM bronze.orders
WHERE order_status = 'delivered'
AND order_id is not null
AND customer_id is not null;