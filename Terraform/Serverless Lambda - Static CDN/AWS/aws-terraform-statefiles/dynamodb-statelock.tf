####################################################################
#        Create a DynamoDB Table for locking the state file
####################################################################
resource "aws_dynamodb_table" "terraform_state_locks" {
  name = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
    tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
        "Description"             = "DynamoDB terraform table to lock states"
      }
}