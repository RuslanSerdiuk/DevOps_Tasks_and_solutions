terraform {
  backend "gcs" {
    credentials = "gcp-key.json"
    bucket      = "mach-bst-terraform-infrastructure"
    prefix      = "mach-bst-infrastructure"
  }
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

# Configure the Google Cloud Provider
provider "google" {
  credentials = file("gcp-key.json")

  project = "or2-msq-epmc-mach-t1iylu"
  region  = "us-central1"
  zone    = "us-central1-c"
}
