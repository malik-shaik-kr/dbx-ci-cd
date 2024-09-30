# Databricks notebook source
from pprint import pformat

print("Fetching Params...")
params: dict = dbutils.widgets.getAll()
print(pformat(params))

print("The data has been successfully extracted!123")
