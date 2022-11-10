import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node DynamoDB table
DynamoDBtable_node1 = glueContext.create_dynamic_frame.from_options(
    connection_type="dynamodb",
    connection_options={
        "dynamodb.export": "ddb",
        "dynamodb.s3.bucket": "aws-glue-assets-384461882996-us-east-1",
        "dynamodb.s3.prefix": "temporary/ddbexport/",
        "dynamodb.tableArn": "arn:aws:dynamodb:us-east-1:384461882996:table/Test-table",
        "dynamodb.unnestDDBJson": True,
    },
    transformation_ctx="DynamoDBtable_node1",
)

# Script generated for node ApplyMapping
ApplyMapping_node2 = ApplyMapping.apply(
    frame=DynamoDBtable_node1,
    mappings=[("AccountId:DeviceId", "string", "AccountId:DeviceId", "string")],
    transformation_ctx="ApplyMapping_node2",
)

# Script generated for node S3 bucket
S3bucket_node3 = glueContext.write_dynamic_frame.from_options(
    frame=ApplyMapping_node2,
    connection_type="s3",
    format="json",
    connection_options={
        "path": "s3://dynamodb-exports-384461882996-us-east-1",
        "compression": "gzip",
        "partitionKeys": [],
    },
    transformation_ctx="S3bucket_node3",
)

job.commit()
