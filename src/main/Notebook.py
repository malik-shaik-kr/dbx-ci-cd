# Databricks notebook source
from pprint import pformat

# COMMAND ----------

dbutils.widgets.text(name="BDS_DB_NAME", defaultValue="release_test")
BDS_DB_NAME = dbutils.widgets.get(name="BDS_DB_NAME")

# COMMAND ----------

params: dict = dbutils.widgets.getAll()
print(pformat(params))

print("SUCCESS")
