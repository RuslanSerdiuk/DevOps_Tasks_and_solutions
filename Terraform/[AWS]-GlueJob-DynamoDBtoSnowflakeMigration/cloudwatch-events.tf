resource "aws_cloudwatch_event_rule" "alarm" {
  name        = "Jobs-alarm"
  description = "Capture each Glue-Job State Change"

  event_pattern = <<EOF
{
  "source": [
    "aws.glue"
  ],
  "detail-type": [
    "Glue Job State Change"
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
    rule = aws_cloudwatch_event_rule.alarm.name
    target_id = "sns-topic-alarms"
    arn = aws_sns_topic.alarms.arn
}


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

resource "aws_cloudwatch_event_target" "Glue_Job_State_Success_for_trigger_export" {
    rule = aws_cloudwatch_event_rule.trigger.name
    target_id = "lambda-function-for-export-data"
    arn = aws_lambda_function.trigger_lambda_export.arn
}
