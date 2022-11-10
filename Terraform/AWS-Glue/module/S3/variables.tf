variable "name_bucket" {
  
}

variable "upload_directory" {
  default = "S3Bucket_files/"
}

variable "mime_types" {
  default = {
    py   = "database/script.py"
    }
}

variable "name" {
  
}