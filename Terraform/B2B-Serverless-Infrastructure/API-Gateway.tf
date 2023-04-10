######################### API Gateway #################################
resource "aws_apigatewayv2_api" "serverless_mach_api" {
  name          = var.api_name
  protocol_type = "HTTP"

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.serverless_mach_api.id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "serverless_mach_integration" {
  api_id           = aws_apigatewayv2_api.serverless_mach_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.serverless_mach.invoke_arn
  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_route" "serverless_mach_route" {
  api_id    = aws_apigatewayv2_api.serverless_mach_api.id

  route_key = var.http_route_key
  target    = "integrations/${aws_apigatewayv2_integration.serverless_mach_integration.id}"
}

###################### Lambda Invoke Permission ########################
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.serverless_mach.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.serverless_mach_api.execution_arn}/*/*"
}

############################### Logs ##################################
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.serverless_mach_api.name}"

  retention_in_days = 30
}