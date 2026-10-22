-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "sqldatawarehouse"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse": "11e01b60-165b-4efa-93a5-85a5f52a83b6",
-- META       "default_lakehouse_name": "lh_e_commerce",
-- META       "default_lakehouse_workspace_id": "58551800-4d5b-4de6-b81f-9e8e5ff7da65",
-- META       "known_lakehouses": [
-- META         {
-- META           "id": "11e01b60-165b-4efa-93a5-85a5f52a83b6"
-- META         }
-- META       ]
-- META     },
-- META     "warehouse": {
-- META       "known_warehouses": []
-- META     }
-- META   }
-- META }

-- CELL ********************

Create view wh_gold_layer.dbo.tempView
AS
SELECT TOP (100) [action],
			[page],
			[timestamp],
			[user_id]
FROM [dbo].[web_logs]

-- METADATA ********************

-- META {
-- META   "language": "sql",
-- META   "language_group": "sqldatawarehouse"
-- META }
