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
  "source": [
    "aws.glue"
  ],
  "detail-type": [
    "Glue Job State Change"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "Check_Glue_Job_State_Changes" {
    rule = aws_cloudwatch_event_rule.trigger.name
    target_id = "lambda-function-for-export-data"
    arn = aws_lambda_function.trigger_lambda_export.arn
}







