resource "aws_glue_job" "export_DB" {
  name     = var.name
  role_arn = "arn:aws:iam::384461882996:role/CreatingTheCommonStack"

  command {
    script_location = var.script_location
  }
}