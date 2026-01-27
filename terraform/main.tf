terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.16.0"
    }
  }
}

provider "google" {
  credentials = "D:/terraformDemo/keys/datacamp-485521-d46999f926ea.json"
  project = "datacamp-485521"
  region  = "us-central1"
}
resource "google_storage_bucket" "demo-bucket" {
  name          = "datacamp-485521-terra-bucket"
  location      = "US"
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}