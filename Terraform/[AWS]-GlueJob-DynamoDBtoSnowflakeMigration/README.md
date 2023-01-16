# Data migration from DynamoDB to S3 and Snowflake

## Tasks:
1. Create Glue-job to migrate data from DynamoDB to S3 Bucket (also create the required bucket). The job should:
    1.1 remove duplicate account_id.
    1.2 launched using a trigger.
2. Create a lambda function to transfer data from S3 Bucket to Snowflake. 
3. Send the CREDENTIALS of Snowflake from the Vault to the Secret Manager in AWS and then use Lambda to take it from there and connecting to the database for transfer the data from S3 to the Snowflake.
3. Create Second failed Glue-job (for tests).
4. Create and implement notifications about state changes of Glue-jobs in Slack channel.
    4.1 Use CloudWatch Event Rule
    4.2 Use SNS Topic
    4.3 Use Lambda
    4.4 Use Slack Incoming Webhook
5. 





