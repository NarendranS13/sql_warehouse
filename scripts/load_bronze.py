import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()

engine_connection = os.getenv('ENGINE_CONNECTION')

## Connection to PostgresSQL DB ecommerce_dw
try:
    engine = create_engine(engine_connection)
    print("Success")
except:
    print("FAILED")

## Customers dataset
# df = pd.read_csv('E:/sql_warehouse/data/raw/olist_customers_dataset.csv')

## Orders dataset
# df = pd.read_csv('E:/sql_warehouse/data/raw/olist_orders_dataset.csv')

### Products dataset
# df = pd.read_csv('E:/sql_warehouse/data/raw/olist_products_dataset.csv')

### Order items dataset
df = pd.read_csv('E:/sql_warehouse/data/raw/olist_order_items_dataset.csv')


## Columns to fetch

## Customers dataset
# cols_to_keep = ['customer_id','customer_city','customer_state']

## Orders dataset
# cols_to_keep = ['order_id','customer_id','order_status','order_purchase_timestamp']

## Product dataset
# cols_to_keep = ['product_id','product_category']

## Order items dataset
cols_to_keep = ['order_id','product_id','price','freight_value']

df_filtered = df[cols_to_keep]

# print(df_filtered.head(10))

### Write the csv to postgresQL

df_filtered.to_sql(
    'order_items', ### customers, ### orders, ### product
    engine,
    schema = 'bronze',
    if_exists = 'append',
    index = False
)

print("Data imported Successfully")