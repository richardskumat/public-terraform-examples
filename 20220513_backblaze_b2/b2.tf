terraform {
  required_version = ">= 1.0.0"
  required_providers {
    b2 = {
      source = "Backblaze/b2"
    }
  }
}

provider "b2" {
}

resource "b2_application_key" "example_bucket_key" {
  key_name     = "example-bucket-key"
  capabilities = ["readFiles","writeFiles"]
}

resource "b2_bucket" "example_bucket" {
  bucket_name = "b2-example"
  bucket_type = "allPrivate"
}