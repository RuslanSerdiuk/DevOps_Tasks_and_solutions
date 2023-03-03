#========================== Glue Job =====================================================
resource "aws_glue_job" "export_DB" {
  name            = var.job_name
  role_arn        = var.role_arn
  description     = "Exports a DynamoDB table to S3"
  glue_version    = "3.0"
  max_retries     = "3"

  default_arguments = {
    "--output_prefix"                    = "s3://${aws_s3_bucket.Export_DynamoDB.id}/${var.script_name}"
    "--read_percentage"                  = "0.25"

    "--job-bookmark-option"            	 = "job-bookmark-enable"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-job-insights"              = "true"
    "--job-language"                     = "python"
  }

  number_of_workers         = 10
  worker_type               = "G.1X"

  command {
    script_location = "s3://${aws_s3_bucket.Export_DynamoDB.id}${var.script_name}"
  }

    tags = {
    Name                      = "${var.backend_role}-${var.finance_env}"
    Role                      = "${var.backend_role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

/*
resource "aws_glue_trigger" "job_trigger" {
  name     = var.name_job_trigger
  schedule = "cron(10 0 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = aws_glue_job.export_DB.name
  }
}
*/
#========================== Glue Job: 2 =============================================

resource "aws_glue_job" "Job_2" {
  name            = var.job_2_name
  role_arn        = var.role_arn
  description     = "JOB_2"
  glue_version    = "3.0"
  max_retries     = "3"

  default_arguments = {
    "--output_prefix"                    = "s3://${aws_s3_bucket.Export_DynamoDB.id}/${var.job_2_script_name}"
    "--read_percentage"                  = "0.25"

    "--job-bookmark-option"            	 = "job-bookmark-enable"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-job-insights"              = "true"
    "--job-language"                     = "python"
  }

  number_of_workers         = 10
  worker_type               = "G.1X"

  command {
    script_location = "s3://${aws_s3_bucket.Export_DynamoDB.id}${var.job_2_script_name}"
  }

    tags = {
    Name                      = "${var.backend_role}-${var.finance_env}"
    Role                      = "${var.backend_role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

/*
resource "aws_glue_trigger" "job_trigger_2" {
  name     = var.name_job_2_trigger
  schedule = "cron(5 0 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = aws_glue_job.Job_2.name
  }
}
*/

#========================== Glue Job: 3 =============================================

resource "aws_glue_job" "Job_3" {
  name            = var.job_3_name
  role_arn        = var.role_arn
  description     = "JOB_3"
  glue_version    = "3.0"
  max_retries     = "3"

  default_arguments = {
    "--output_prefix"                    = "s3://${aws_s3_bucket.Export_DynamoDB.id}/${var.job_3_script_name}"
    "--read_percentage"                  = "0.25"

    "--job-bookmark-option"            	 = "job-bookmark-enable"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-job-insights"              = "true"
    "--job-language"                     = "python"
  }

  number_of_workers         = 10
  worker_type               = "G.1X"

  command {
    script_location = "s3://${aws_s3_bucket.Export_DynamoDB.id}${var.job_3_script_name}"
  }

    tags = {
    Name                      = "${var.backend_role}-${var.finance_env}"
    Role                      = "${var.backend_role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

/*
resource "aws_glue_trigger" "job_trigger_3" {
  name     = var.name_job_3_trigger
  schedule = "cron(0 0 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = aws_glue_job.Job_3.name
  }
}
*/

/*
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
*/
