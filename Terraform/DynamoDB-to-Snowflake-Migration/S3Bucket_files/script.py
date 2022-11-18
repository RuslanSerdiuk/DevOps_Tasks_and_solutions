import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame
from pyspark.sql import functions as SqlFuncs

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)


fortniteTable = glueContext.create_dynamic_frame.from_options(
    connection_type ="dynamodb",
    connection_options = {
        "dynamodb.input.tableName": "communications_devices_prod",
    },
    transformation_ctx="fortniteTable",
)

rlssTable = glueContext.create_dynamic_frame.from_options(
    connection_type ="dynamodb",
    connection_options = {
        "dynamodb.input.tableName": "communications_multitenant_device_prod",
    },
    transformation_ctx="rlssTable",
)

rlssDF = rlssTable.toDF()
rlssTable = DynamicFrame.fromDF(
    rlssDF.withColumn('accountid', SqlFuncs.split(rlssDF["TenantId#AccountId"], "#").getItem(1)),
    glueContext,
    "rlssTable",
)


mappedFortnite = ApplyMapping.apply(
    frame=fortniteTable,
    mappings=[("accountid", "string", "accountid", "string")],
    transformation_ctx="mappedFortnite",
)

mappedRlss = ApplyMapping.apply(
    frame=rlssTable,
    mappings=[("accountid", "string", "accountid", "string")],
    transformation_ctx="mappedRlss",
)

mappedRlss.toDF().show();

DropDuplicates = DynamicFrame.fromDF(
    mappedFortnite.toDF().union(mappedRlss.toDF()).dropDuplicates().repartition(1),
    glueContext,
    "DropDuplicates",
)

AmazonS3 = glueContext.write_dynamic_frame.from_options(
    frame=DropDuplicates,
    connection_type="s3",
    format="csv",
    connection_options={
        "path": "s3://pns-bucket-for-export-dynamodb-pd/",
        "compression": "gzip",
        "partitionKeys": [],
    },
    transformation_ctx="AmazonS3",
)

job.commit()
