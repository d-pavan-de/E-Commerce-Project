-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "sqldatawarehouse"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse_name": "",
-- META       "default_lakehouse_workspace_id": "",
-- META       "known_lakehouses": []
-- META     },
-- META     "warehouse": {
-- META       "default_warehouse": "15860c1d-c392-ae7f-4c8d-d9d502d7def1",
-- META       "known_warehouses": [
-- META         {
-- META           "id": "15860c1d-c392-ae7f-4c8d-d9d502d7def1",
-- META           "type": "Datawarehouse"
-- META         },
-- META         {
-- META           "id": "53c780f8-35a5-43e3-bad0-774fb2472ad7",
-- META           "type": "Lakewarehouse"
-- META         }
-- META       ]
-- META     }
-- META   }
-- META }

-- CELL ********************

IF NOT EXISTS ( SELECT *
 FROM sys.schemas
 WHERE name = N'ecom' )
 EXEC('CREATE SCHEMA [ecom] AUTHORIZATION [dbo]');
GO



-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

IF OBJECT_ID('wh_e_commerce_gold_data.ecom.customers_orderdata_gold', 'U') IS NOT NULL
    BEGIN
        DROP TABLE wh_e_commerce_gold_data.ecom.customers_orderdata_gold
    END

CREATE TABLE wh_e_commerce_gold_data.ecom.customers_orderdata_gold AS 
        SELECT * FROM [lh_e_commerce].[silver].[combined_order_details]
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

IF OBJECT_ID('wh_e_commerce_gold_data.ecom.web_logs_gold', 'U') IS NOT NULL
    BEGIN
        DROP TABLE wh_e_commerce_gold_data.ecom.web_logs_gold
    END

CREATE TABLE wh_e_commerce_gold_data.ecom.web_logs_gold AS 
    SELECT user_id, page, action, Count(*) as count FROM [lh_e_commerce].[silver].[web_logs]
    GROUP BY user_id, page, action
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

IF OBJECT_ID('wh_e_commerce_gold_data.ecom.social_media_gold', 'U') IS NOT NULL
    BEGIN
        DROP TABLE wh_e_commerce_gold_data.ecom.social_media_gold
    END

CREATE TABLE wh_e_commerce_gold_data.ecom.social_media_gold AS 
    SELECT platform, sentiment, Count(*) as count FROM [lh_e_commerce].[silver].[social_media]
    GROUP BY platform, sentiment
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }

-- CELL ********************

IF OBJECT_ID('wh_e_commerce_gold_data.ecom.reviews_gold', 'U') IS NOT NULL
    BEGIN
        DROP TABLE wh_e_commerce_gold_data.ecom.reviews_gold
    END

CREATE TABLE wh_e_commerce_gold_data.ecom.reviews_gold AS 
    SELECT product_id, avg("rating") as AvgRating FROM [lh_e_commerce].[silver].[product_reviews]
    GROUP BY product_id
GO

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }
