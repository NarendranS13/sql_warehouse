DROP TABLE IF EXISTS silver.customers;

CREATE TABLE silver.customers AS
select distinct 
	customer_id, 
	customer_city, 
	customer_state 
	from 
	bronze.customers
where customer_id is not null;