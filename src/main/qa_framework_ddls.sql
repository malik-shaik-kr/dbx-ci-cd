-- Databricks notebook source
-- MAGIC %python
-- MAGIC import os

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Import Constants File

-- COMMAND ----------

-- MAGIC %run ../utils/constants

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### setEnvironment Variable

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.widgets.text(name="env", defaultValue=os.environ.get("BDS_QA_ENV", "Development"))
-- MAGIC constants = get_constants(dbutils.widgets.get("env"))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Prepare Catalog and Schema Names

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.widgets.text(name="BDS_CATALOG_NAME", defaultValue=constants["BDS_CATALOG_NAME"])
-- MAGIC dbutils.widgets.text(name="BDS_SCHEMA_NAME", defaultValue=constants["BDS_SCHEMA_NAME"])

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Set CATALOG and SCHEMA Names for the SQL Context

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.sql(f"USE CATALOG {constants['BDS_CATALOG_NAME']}")
-- MAGIC spark.sql(f"USE SCHEMA {constants['BDS_SCHEMA_NAME']}")

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### DDL - BDS_QA_RULE

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS bds_qa_rule (
  rule_id STRING
  COMMENT 'A unique identifier assigned to each rule, ensuring distinct identification for rule management and tracking purposes.',
  rule_type STRING
  COMMENT 'Specifies the category of the rule, such as validation, transformation, or enrichment, indicating its primary function within the data processing workflow.',
  rule_granularity STRING
  COMMENT 'Defines the level of specificity at which the rule is applied, such as row-level (affecting individual records) or column-level (targeting specific fields).',
  rule_layer STRING
  COMMENT 'Identifies the layer within the data architecture where the rule is enforced, such as the data source layer or processing layer, providing context for its application.',
  rule_summary STRING
  COMMENT 'A concise overview that encapsulates the main purpose or function of the rule, allowing quick understanding of its role.',
  rule_description STRING
  COMMENT 'A comprehensive explanation detailing the rule\'s logic, the rationale behind its creation, and guidelines for its application in data processes.',
  rule_story_linkage STRING
  COMMENT 'Links to a specific user story or requirement that this rule supports, providing traceability and context within project management tools.',
  rule_precondition STRING
  COMMENT 'Specifies any prerequisites or conditions that must be fulfilled for the rule to be applicable, ensuring proper execution in relevant scenarios.',
  rule_query STRING
  COMMENT 'Contains the SQL statement or query expression that encapsulates the logic of the rule, serving as a technical reference for implementation.',
  rule_threshold_type STRING
  COMMENT 'Describes the nature of the threshold applied by the rule, such as static (fixed value) or dynamic (variable based on data), influencing rule behavior.',
  rule_threshold_value STRING
  COMMENT 'Represents the specific threshold value that the rule utilizes to evaluate conditions, determining when the rule\'s actions should trigger.',
  rule_action STRING
  COMMENT 'Outlines the specific action to be executed when the rule\'s conditions are met, such as generating alerts, logging events, or halting processes.',
  rule_test_data STRING
  COMMENT 'Provides sample data or scenarios used to validate the rule\'s functionality during testing, ensuring reliability before deployment.',
  rule_expected_result STRING
  COMMENT 'Describes the anticipated outcome when the rule is applied to the specified test data, serving as a benchmark for successful rule execution.',
  rule_qmetry_issue_key STRING
  COMMENT 'References an issue key within QMetry, a test management tool, if applicable, facilitating integration with issue tracking and management processes.',
  is_rule_active BOOLEAN
  COMMENT 'Indicates the current operational status of the rule; true signifies that the rule is active and enforced, while false indicates it is inactive.',
  rule_updated_at TIMESTAMP
  COMMENT 'Records the date and time of the last modification made to the rule, enabling tracking of changes and version history.',
  rule_created_at TIMESTAMP
  COMMENT 'Captures the date and time when the rule was originally created, providing context for its lifecycle and relevance in the data processing pipeline.'
) -- USING DELTA
COMMENT 'Table for storing quality assurance rules applied to data, including rule definitions, conditions, and expected outcomes.';
-- LOCATION '/mnt/delta/kr_retail_sales_nonprod/trans_raw_t/bds_qa_rule';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### DDL - BDS_QA_TEST_RESULTS

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS bds_qa_test_results (
  tr_id BIGINT
  COMMENT 'A unique identifier for each test result entry, facilitating distinct identification and management of test outcomes.',
  tr_rule_id STRING
  COMMENT 'References the unique identifier of the associated QA rule, linking the test result to its corresponding rule for traceability.',
  tr_type STRING
  COMMENT 'Specifies the type of test conducted, such as EOD-RECONCILIATION or JOB, indicating the context of the validation performed.',
  tr_md_batch_id BIGINT
  COMMENT 'Identifies the specific batch of data being validated, allowing for tracking and aggregation of results per data batch.',
  tr_status STRING
  COMMENT 'Denotes the outcome of the test, such as PASS or FAIL, providing a clear indication of whether the data met the validation criteria.',
  tr_message STRING
  COMMENT 'A brief message summarizing the test outcome, providing quick insight into the success or failure of the validation process.',
  tr_details STRING
  COMMENT 'Contains detailed information regarding the test execution, including query results, thresholds, and other relevant metrics for analysis.',
  tr_updated_at TIMESTAMP
  COMMENT 'Records the date and time of the last modification made to the test result, enabling tracking of updates and changes over time.',
  tr_created_at TIMESTAMP
  COMMENT 'Captures the date and time when the test result was originally created, providing context for its lifecycle and relevance in the QA process.'
) -- USING DELTA
COMMENT 'Table for storing results of QA tests conducted on data batches, including validation outcomes, associated rules, and execution details.' -- LOCATION '/mnt/delta/kr_retail_sales_nonprod/trans_raw_t/bds_qa_test_results';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### DDL - BDS_QA_METRICS

-- COMMAND ----------
DROP TABLE IF EXISTS bds_qa_metrics;
CREATE TABLE IF NOT EXISTS bds_qa_metrics (
  metric_id BIGINT
  COMMENT 'A unique identifier for each metric record. This ID serves as a primary key for tracking individual QA metrics and is crucial for referencing specific records in reporting and analysis.',
  md_batch_id BIGINT
  COMMENT 'The unique identifier for the data batch being evaluated. This ID links the metrics to the specific batch of data, enabling users to assess the quality of individual data loads.',
  metric_query_count INT
  COMMENT 'The total number of queries executed during the quality assurance process for the corresponding batch. This metric provides insights into the extent of the quality checks performed, indicating the complexity and thoroughness of the QA process.',
  metric_query_pass_count INT
  COMMENT 'The count of queries that passed the quality checks successfully. This number reflects the integrity of the data and the effectiveness of the QA rules applied, highlighting how many conditions were met without issues.',
  metric_query_fail_count INT
  COMMENT 'The count of queries that failed the quality checks. This metric is critical for identifying potential data integrity issues, as it indicates how many checks did not meet the established criteria, prompting further investigation and remediation.',
  qa_job_params STRING
  COMMENT 'A JSON string containing parameters associated with the QA job, such as the md_batch_id, catalog name, schema name, and database name. This information provides additional context regarding the job’s configuration and environment, facilitating better understanding and reproducibility of the QA processes.'
)
COMMENT 'Table for storing metrics related to quality assurance processes applied to batches of data, including pass/fail counts and job metadata.';
