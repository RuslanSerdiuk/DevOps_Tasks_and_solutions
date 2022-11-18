#========================== Secret Manager =====================================================

resource "aws_secretsmanager_secret" "example" {
  name = "example"
}