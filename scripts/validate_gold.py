import os
import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

engine_connection = os.getenv('ENGINE_CONNECTION')

## Connection to PostgresSQL DB ecommerce_dw
try:
    engine = create_engine(engine_connection)
    print("Success")
except:
    print("FAILED")

#### Pull Gold Tables
#### Monthly Revenue
monthly_revenue = pd.read_sql(
    "SELECT * FROM ecommerce_dw.gold.monthly_revenue_orders ORDER BY year_month;",
    engine
)

print(monthly_revenue)

#### City level metrics

city_metrics = pd.read_sql(
    "SELECT * FROM ecommerce_dw.gold.city_wise_revenue",
    engine
)

#### Validation Check

# Check for nulls
assert monthly_revenue.isnull().sum().sum() == 0, "Null values found in monthly revenue"

# Check revenue is positive
assert (monthly_revenue["total_revenue"] < 0).sum() == 0, "Negative revenue detected"

# Check months are increasing

assert monthly_revenue["year_month"].is_monotonic_increasing, "Months are not ordered"

### Visualization 1: Monthly revenue Trend

plt.figure(figsize=(10,5))
plt.plot(monthly_revenue["year_month"], monthly_revenue['total_revenue'])
plt.title("Monthly Revenue Trend")
plt.xlabel("Year-Month")
plt.ylabel("Total Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

#### Visualization 2: Top cities by revenue

top_cities = city_metrics.groupby("customer_city")["total_revenue"].sum().sort_values(ascending=False).head(10)

plt.figure(figsize=(10, 5))
top_cities.plot(kind="bar")
plt.title("Top 10 Cities by Revenue")
plt.xlabel("City")
plt.ylabel("Total Revenue")
plt.tight_layout()
plt.show()

print("Gold validation and visualization completed successfully.")