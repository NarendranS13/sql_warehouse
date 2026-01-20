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

