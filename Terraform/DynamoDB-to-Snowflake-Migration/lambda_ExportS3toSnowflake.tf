
resource "aws_lambda_function" "export_from_s3_to_snowflake" {
  # s3_bucket = "s3://${var.name_bucket}-${var.name_env}"

  # s3_bucket = var.S3Bucket_id
  # s3_key    = var.s3_key_file
  
  function_name = "${var.function_name}-${var.name_env}"
  role          = var.role
  handler       = var.lambda_export_s3_to_snowflake_handler
  runtime       = "nodejs12.x"
  timeout       = 3

  filename         = var.filename
  # source_code_hash = filebase64sha256("../src.zip")
  /*
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_groups
  }
  
  environment {
    variables = {
      API_BASE_URL       = var.API_BASE_URL
      NODE_ENV           = var.NODE_ENV
      AUTO_USER_NAME     = var.AUTO_USER_NAME
      AUTO_USER_PASSWORD = var.AUTO_USER_PASSWORD
    }
  }
  */
  tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
    "EpicFinance:Owner"       = var.finance_owner
  }
}

# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = "s3://${var.name_bucket}-${var.name_env}"
  lambda_function {
    lambda_function_arn = aws_lambda_function.export_from_s3_to_snowflake.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

  }
}

resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.export_from_s3_to_snowflake.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.name_bucket}-${var.name_env}"
}