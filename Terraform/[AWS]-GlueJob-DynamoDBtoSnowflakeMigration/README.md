# Data migration from DynamoDB to S3 and Snowflake

## Tasks:
1. Create Glue-job to migrate data from DynamoDB to S3 Bucket (also create the required bucket). The job should:

    1.1. remove duplicate account_id. 

    1.2. launched using a trigger.

2. Create a lambda function to transfer data from S3 Bucket to Snowflake. 
3. Send the CREDENTIALS of Snowflake from the Vault to the Secret Manager in AWS and then use Lambda to take it from there and connecting to the database for transfer the data from S3 to the Snowflake.
4. Create Second failed Glue-job (for tests).
5. Create and implement notifications about state changes of Glue-jobs in Slack channel.
    4.1 Use CloudWatch Event Rule
    4.2 Use SNS Topic
    4.3 Use Lambda
    4.4 Use Slack Incoming Webhook
6. 





### _LINKS:_
+ _https://docs.aws.amazon.com/sns/latest/dg/sns-message-and-json-formats.html#http-notification-json_
+ _https://aws.amazon.com/ru/premiumsupport/knowledge-center/sns-lambda-webhooks-chime-slack-teams/_
+ _https://api.slack.com/apps/A04GBQNBQUR/incoming-webhooks?_
+ _https://taskssolutions.slack.com/apps/A04GBQNBQUR-glue-job-alarm?tab=settings&next_id=0_
+ _https://app.slack.com/block-kit-builder_
+ _https://aws.amazon.com/ru/blogs/big-data/how-to-export-an-amazon-dynamodb-table-to-amazon-s3-using-aws-step-functions-and-aws-glue/_
+ _https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_
+ _https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission_
+ _https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target_
+ _https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-patterns.html_
+ _https://stackoverflow.com/questions/49341187/confirming-aws-sns-topic-subscription-for-slack-webhook_
+ _https://www.youtube.com/watch?v=ox_HJ8w7FPI_
