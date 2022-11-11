#========================== Glue Job =====================================================
resource "aws_glue_job" "export_DB" {
  name     = var.name
  role_arn = "arn:aws:iam::384461882996:role/AWSGlueServiceRoleDefault"
  description = "Exports a DynamoDB table to S3"
  
  default_arguments = {
    "--glue_job_name" = "TEST-2"
    "--output_prefix" = "s3://bucket-script-for-export-db-us-east-2"
    "--table_name" = "Test-table"
    "--read_percentage" = "0.25"
    "--output_format" = "json"
  }

  command {
    script_location = var.script_location
  }
}


#========================== STEP Function =====================================================
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "DynamoDBExport"
  role_arn = "arn:aws:iam::384461882996:role/Test1000000-blet-StateExecutionRole-1AUJWKAWIP11G"

  definition = <<EOF
{
  "StartAt": "Start Glue Job",
  "States": {
    "Start Glue Job": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName.$": "$.glue_job_name",
        "Arguments": {
          "--table_name.$": "$.table_name",
          "--read_percentage.$": "$.read_percentage",
          "--output_prefix.$": "$.output_prefix",
          "--output_format.$": "$.output_format"
        }
      }, "End": true
    }
  }
}
EOF
}


#========================== Event Trigger  =====================================================
resource "aws_cloudwatch_event_rule" "trigger_glue_job" {
  name                = "GlueDynamoExportTableExport-Trigger"
  description         = "Start Export of Test-table every minute"
  schedule_expression = "cron(1 0 * * ? *)"
}

resource "aws_cloudwatch_event_target" "trigger_glue_job" {
  target_id = "GlueDynamoExportTableExport-Trigger"
  arn       = aws_sfn_state_machine.sfn_state_machine.arn
  input = <<DOC
{
  "glue_job_name": "TEST-2",
  "output_prefix": "s3://bucket-script-for-export-db-us-east-2",
  "table_name": "Test-table",
  "read_percentage": "0.25",
  "output_format": "json"
}
DOC
  rule      = aws_cloudwatch_event_rule.trigger_glue_job.name
  role_arn  = "arn:aws:iam::384461882996:role/Test1000000-blet-EventTriggerRole-QSEIY0VQBXJE"
}




