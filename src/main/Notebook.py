# Databricks notebook source
import logging
import random
import time
from datetime import datetime, timezone
from pprint import pformat

import pytz
from diem.monitoring.tracker import Application, MedallionLayer, Tracker

# COMMAND ----------

start_dt = datetime.now(timezone.utc)

# COMMAND ----------

params: dict = {}
try:
    params = dbutils.widgets.getAll()
except Exception as e:
    print("Failed to parse Params")
print(pformat(params))

# COMMAND ----------

bds_count: int = random.randint(1, 999999)

tracker = Tracker(
    Application(
        domain="BDS",
        name="BDS-QA-AUTOMATION",
        job_id=params.get("JOB_ID", 1),
        run_id=params.get("JOB_RUN_ID", 1),
        transaction_id=0,
        tags={"env": "Development", "searchKey": "BDS_QA_DD"},
    )
)
tracker.logger.setLevel(logging.INFO)  ## Set Log Level

# COMMAND ----------

end_dt = datetime.now(timezone.utc)

# COMMAND ----------

# Now use bds_count in the tracker.record function
tracker.record(
    layer=MedallionLayer.LANDING,
    records=bds_count,
    accepted=bds_count,
    violations=1,
    duration=(end_dt - start_dt).total_seconds(),
    log={
        "bds-record-name": "bds-daily-count",
        "trxdate": datetime.now(pytz.utc).date(),
        "bds_count": bds_count,
        "job_params": params,
    },
)

###### Query to search in datadog:
#####  index:datadog-bulkdataservices-index env:nonprod -source:(spark OR stdout) @application:BDS-QA-AUTOMATION
