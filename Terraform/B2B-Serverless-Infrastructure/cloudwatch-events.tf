################### rule for lambda trigger ###################
resource "aws_cloudwatch_event_rule" "b2b_project_fift_min_event" {
  name                = "b2b_project_${var.name_env}"
  description         = "Trigger function every 15 minutes"
  schedule_expression = "cron(*/15 * * * ? *)"

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

resource "aws_cloudwatch_event_target" "trigger_lambda_warming" {
    rule = aws_cloudwatch_event_rule.b2b_project_fift_min_event.name
    target_id = "trigger-for-lambda-warming"
    arn = aws_lambda_function.serverless_mach.arn
}
