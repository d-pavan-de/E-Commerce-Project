# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "6dc2d01d-e7c5-47a7-9e27-2e013b5d7ba7",
# META       "default_lakehouse_name": "Bronze",
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

df_reviews = spark.read.format("json").load("Files/ShoppingMart_Bronze_Reviews/ShoppingMart_review.json")
df_social_media = spark.read.format("json").load("Files/ShoppingMart_Bronze_Social_Media/ShoppingMart_social_media.json")
df_Web_Logs = spark.read.format("json").load("Files/ShoppingMart_Bronze_Web_Logs/ShoppingMart_web_logs.json")

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

## Orders data cleaning and enrichment
 
df_orders = df_orders.dropna(subset=['OrderID','CustomerID','ProductID','TotalAmount'])
df_orders = df_orders.withColumn('OrderDate',F.to_date(F.col('OrderDate')))
df_orders = df_orders.withColumn('TotalAmount',F.col('TotalAmount').cast("decimal(18, 2)"))

## Customers data cleaning and enrichment
# drop null records
df_customer = df_customer.dropna(subset=['CustomerID'])

## Products data cleaning and enrichment
# drop null records
df_products = df_products.dropna(subset=['ProductID'])

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_combined = df_orders\
.join(df_customer, on = 'CustomerID', how='inner')\
.join(df_products, on = 'ProductID' , how='inner')

df_combined.write.format("delta").mode('overwrite').saveAsTable('silver_data.dbo.combined_order_details')

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_reviews.write.format("delta").mode('overwrite').saveAsTable('silver_data.dbo.product_reviews')
df_Web_Logs.write.format("delta").mode('overwrite').saveAsTable('silver_data.dbo.web_logs')
df_social_media.write.format("delta").mode('overwrite').saveAsTable('silver_data.dbo.social_media')

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
