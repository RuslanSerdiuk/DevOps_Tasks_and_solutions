import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame
from pyspark.sql import functions as SqlFuncs
from datetime import date


args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)
today = date.today()

emailSettings = glueContext.create_dynamic_frame.from_options(
    connection_type ="dynamodb",
    connection_options = {
        "dynamodb.input.tableName": "communications_settings_prod",
        "dynamodb.splits": "72"
    },
    transformation_ctx="emailSettings",
)

mappedEmailSettings = ApplyMapping.apply(
    frame=emailSettings,
    mappings=[
        ("accountid", "string", "accountid", "string"),
        ("scope", "string", "scope", "string"),
        ("value", "integer", "value", "integer")
    ],
    transformation_ctx="mappedEmailSettins",
)

# sparkDF = mappedEmailSettings.toDF();
# sparkDF.write.option("compression", "gzip").option("maxRecordsPerFile",5000000).csv('s3a://communications-bucket-for-export-dynamodb-pd/email-settings-export/');

s3 = glueContext.write_dynamic_frame.from_options( 
    frame = mappedEmailSettings, 
    connection_type = "s3", 
    connection_options = {
        "path": f"s3://communications-bucket-for-export-dynamodb-test-pd/email-settings-export/{today}",
        "compression": "gzip"
    }, 
    format = "csv", 
    transformation_ctx = "s3")

job.commit()
