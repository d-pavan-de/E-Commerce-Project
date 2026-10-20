# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "6dc2d01d-e7c5-47a7-9e27-2e013b5d7ba7",
# META       "default_lakehouse_name": "Transactions",
# META       "default_lakehouse_workspace_id": "58551800-4d5b-4de6-b81f-9e8e5ff7da65",
# META       "known_lakehouses": [
# META         {
# META           "id": "6dc2d01d-e7c5-47a7-9e27-2e013b5d7ba7"
# META         }
# META       ]
# META     }
# META   }
# META }

# MARKDOWN ********************

# # Transform Bronze Data


# CELL ********************

from pyspark.sql import functions as F

df_customer = spark.read.format("csv").option("header","true").load("Files/ShoppingMart_Bronze_Customers/ShoppingMart_customers.csv")
df_orders = spark.read.format("csv").option("header","true").load("Files/ShoppingMart_Bronze_Orders/ShoppingMart_orders.csv")
df_products = spark.read.format("csv").option("header","true").load("Files/ShoppingMart_Bronze_Products/ShoppingMart_products.csv")
# df now is a Spark DataFrame containing CSV data from "Files/ShoppingMart_Bronze_Customers/ShoppingMart_customers.csv".
# display(df_orders)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# MARKDOWN ********************

# ## data cleaning and enrichment

# MARKDOWN ********************


# CELL ********************

df_orders = df_orders.dropna(subset=['OrderID','CustomerID','ProductID','TotalAmount'])
df_orders = df_orders.withColumn('OrderDate',to_date(col('OrderDate')))
df_orders = df_orders.withColumn('TotalAmount',F.col('TotalAmount').cast("decimal(18, 2)"))
display(df_orders)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

display(df_orders)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
