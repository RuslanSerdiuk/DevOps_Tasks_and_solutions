################### Rules For lambda trigger ###################
###################### Backend Lambda ##########################
resource "aws_cloudwatch_event_rule" "b2b_project_fift_min_event" {
  name                = "${var.backend_role}-rule-${var.name_env}"
  description         = "Trigger ${var.backend_role}-${var.name_env} function every 15 minutes"
  schedule_expression = "cron(*/15 * * * ? *)"

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

resource "aws_cloudwatch_event_target" "trigger_lambda_for_serverless_backend" {
    rule = aws_cloudwatch_event_rule.b2b_project_fift_min_event.name
    target_id = "trigger-for-lambda-warming"
    arn = aws_lambda_function.lambda_for_serverless_backend.arn
}

##################### API Trigger Lambda #########################
resource "aws_cloudwatch_event_rule" "b2b_project_twelve_hours_event" {
  name                = "${var.backend_role}-api-call-rule-${var.name_env}"
  description         = "Trigger ${var.backend_role}-api-call-${var.name_env} function every 12 hours"
  schedule_expression = "cron(* */12 * * ? *)"

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

resource "aws_cloudwatch_event_target" "trigger_lambda_for_api_call" {
    rule = aws_cloudwatch_event_rule.b2b_project_twelve_hours_event.name
    target_id = "trigger-for-api-call"
    arn = aws_lambda_function.lambda_for_api_call.arn
}




