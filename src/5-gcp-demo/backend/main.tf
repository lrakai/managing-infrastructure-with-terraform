provider "google" {
  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "us-central1"
}

resource "google_storage_bucket" "backend" {
  name     = "ca-demo-tf-state"
  location = "US"
}
