variable "name_bucket" {
  
}

variable "upload_directory" {
  default = "S3Bucket_files/"
}

variable "mime_types" {
  default = {
    php   = "includes/html"
    sql   = "database/script.sql"
    }
}

variable "name" {
  
}