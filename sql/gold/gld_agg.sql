select
date_trunc('month', o.order_date )as year_month,
	SUM(oi.price + oi.freight_value) as total_revenue,
	COUNT(distinct o.order_id)as total_orders
	from 
(
	select 
	distinct
	order_id,
	order_date
	from ecommerce_dw.silver.orders
	
)as o
join 
(
select
*
from
ecommerce_dw.silver.order_items
)as oi
on (o.order_id = oi.order_id)
GROUP BY 1
ORDER BY 1;

--- Check city wise order revenue data

SELECT CU.CUSTOMER_CITY, DATE_TRUNC('month', O.ORDER_DATE)as YEAR_MONTH, COUNT (DISTINCT CU.CUSTOMER_ID)AS TOTAL_USERS,
		SUM(oi.price + oi.freight_value) as total_revenue,
	COUNT(distinct o.order_id)as total_orders from 
silver.customers cu
JOIN
silver.orders o 
ON (cu.customer_id = o.customer_id)
JOIN
silver.order_items oi
ON (o.order_id = oi.order_id)
GROUP BY 1,2
ORDER BY TOTAL_USERS DESC;

--- Monthly revenue by Product Category

SELECT DATE_TRUNC('month', o.order_date)as YEARMONTH, p.product_category, 
	SUM (oi.price + oi.freight_value)as total_revenue, 
	COUNT (DISTINCT o.order_id)as total_orders
FROM silver.orders o
JOIN silver.order_items oi
ON (o.order_id = oi.order_id)
JOIN silver.products p
ON (oi.product_id = p.product_id)
GROUP BY 1,2
ORDER BY 1, total_revenue DESC;


-- CUSTOMER LIFETIME VALUE (CLV)

SELECT
	o.customer_id,  zzzz
	SUM(oi.price + oi.freight_value)as total_revenue,
	COUNT(DISTINCT o.order_id)as total_orders,
	MIN(o.order_date)as first_purchase_date,
	MAX(o.order_date)as last_purchase_date
FROM silver.orders as o
JOIN silver.order_items as oi
ON (o.order_id= oi.order_id)
GROUP BY 1
ORDER BY total_revenue DESC;


--- Top Products by Revenue 

SELECT
    p.product_id,
    p.product_category,
    SUM(oi.price + oi.freight_value) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM silver.order_items oi
JOIN silver.orders o
  ON oi.order_id = o.order_id
JOIN silver.products p
  ON oi.product_id = p.product_id
GROUP BY 1, 2
ORDER BY total_revenue DESC
LIMIT 20;
