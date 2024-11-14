-- Databricks notebook source


-- MAGIC %md
-- MAGIC ### DDL - BDS_QA_METRICS

-- COMMAND ----------
DROP TABLE IF EXISTS kr_retail_sales_nonprod.trans_raw_d.bds_qa_metrics;

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
TBLPROPERTIES (
                  'delta.deletedFileRetentionDuration' = 'interval 7 days',
                  'delta.enableChangeDataFeed' = 'true',
                  'delta.enableDeletionVectors' = 'true',
                  'delta.feature.changeDataFeed' = 'supported',
                  'delta.feature.deletionVectors' = 'supported',
                  'delta.logRetentionDuration' = 'interval 30 days',
                  'delta.minReaderVersion' = '3',
                  'delta.minWriterVersion' = '7'
                )
COMMENT 'Table for storing metrics related to quality assurance processes applied to batches of data, including pass/fail counts and job metadata.';

-- COMMAND ----------
DROP TABLE IF EXISTS kr_retail_sales_nonprod.trans_raw_t.bds_qa_metrics;
CREATE TABLE IF NOT EXISTS kr_retail_sales_nonprod.trans_raw_t.bds_qa_metrics (
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
TBLPROPERTIES (
                  'delta.deletedFileRetentionDuration' = 'interval 7 days',
                  'delta.enableChangeDataFeed' = 'true',
                  'delta.enableDeletionVectors' = 'true',
                  'delta.feature.changeDataFeed' = 'supported',
                  'delta.feature.deletionVectors' = 'supported',
                  'delta.logRetentionDuration' = 'interval 30 days',
                  'delta.minReaderVersion' = '3',
                  'delta.minWriterVersion' = '7'
                )
COMMENT 'Table for storing metrics related to quality assurance processes applied to batches of data, including pass/fail counts and job metadata.';
