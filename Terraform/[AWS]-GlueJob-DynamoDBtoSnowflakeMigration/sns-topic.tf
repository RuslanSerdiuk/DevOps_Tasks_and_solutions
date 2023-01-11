# Create an IAM role for the SNS with access to CloudWatch
/*
resource "aws_iam_role" "sns_logs" {
  name = "sns-logs"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Allow SNS to write logs to CloudWatch
resource "aws_iam_role_policy_attachment" "sns_logs" {
  role       = aws_iam_role.sns_logs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSNSRole"
}
*/
# Create an SNS topic to receive notifications from CloudWatch
resource "aws_sns_topic" "alarms" {
  name = "alarms"

  # Important! Only for testing, set to log every single message 
  # For production, set it to 0 or close
  lambda_success_feedback_sample_rate = 100

  lambda_failure_feedback_role_arn = "arn:aws:iam::384461882996:role/sns-log"
  lambda_success_feedback_role_arn = "arn:aws:iam::384461882996:role/sns-log"
}

# Trigger lambda function when a message is published to "alarms" topic
resource "aws_sns_topic_subscription" "alarms" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.GlueJobSlackAlarm.arn
}

# This policy defines who can access your topic
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.alarms.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "sns:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.alarms.arn,
    ]

    sid = "__default_statement_ID"
  }
}



