################### rule for lambda trigger ###################

resource "aws_cloudwatch_event_rule" "trigger" {
  name        = "Jobs-trigger"
  description = "Capture each Glue-Job State Change"

  event_pattern = <<EOF
{
  "detail": {
    "state": [
      "SUCCEEDED"
    ],
    "jobName": [
        "export_communications_settings_prod_to_s3"
    ]
  },
  "detail-type": [
    "Glue Job State Change"
  ],
  "source": [
    "aws.glue"
  ]
}
EOF

tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

resource "aws_cloudwatch_event_target" "Glue_Job_State_Success_for_trigger_export" {
    rule = aws_cloudwatch_event_rule.trigger.name
    target_id = "communications-lambda-glue-trigger-for-export-data"
    arn = aws_lambda_function.trigger_lambda_export.arn
}


########## rule for glue-jobs state change lambda alert to slack #############

resource "aws_cloudwatch_event_rule" "GlueJobsStateChange-AlertToSlack" {
  name        = "GlueJobsStateChange-AlertToSlack"
  description = "Capture each Glue-Job State Change"

  event_pattern = <<EOF
{
  "detail": {
    "jobName": [
        "export_communications_settings_prod_to_s3",
        "CommService_DynamoDB_to_s3"
    ]
  },
  "detail-type": [
    "Glue Job State Change"
  ],
  "source": [
    "aws.glue"
  ]
}
EOF

tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

resource "aws_cloudwatch_event_target" "Check_Glue_Job_State_Changes" {
    rule = aws_cloudwatch_event_rule.GlueJobsStateChange-AlertToSlack.name
    target_id = "communications-lambda-glue-jobs-state-change-alert-to-slack"
    arn = aws_sns_topic.GlueJobsStateChange-AlertToSlack.arn
}
