-- CREATE SCHEMAS FOR BRONZE, SILVER and GOLD in ecommerce_dw

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

CREATE TABLE bronze.customers (
customer_id VARCHAR(200),
customer_city VARCHAR(200),
customer_state TIMESTAMP,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE bronze.orders (
order_id VARCHAR(200),
customer_id VARCHAR(200),
order_status VARCHAR(200),
order_purchase_timestamp TIMESTAMP,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bronze.products (
product_id VARCHAR(200),
product_category VARCHAR(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE bronze.orders_items (
order_id VARCHAR(200),
product_id VARCHAR(200),
price NUMERIC,
freight_value NUMERIC,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);