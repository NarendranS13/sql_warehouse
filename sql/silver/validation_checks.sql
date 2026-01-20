-- Integrity Checks

-- Order without customers

SELECT COUNT(*) 
FROM silver.orders o 
LEFT JOIN silver.customers c
	on o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items without orders

SELECT *
FROM silver.order_items oi 
LEFT JOIN silver.orders o
	on oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- --- Order items without products
SELECT COUNT(*)
FROM silver.order_items oi
LEFT JOIN silver.products p
  ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;