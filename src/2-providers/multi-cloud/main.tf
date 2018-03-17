provider "google" {
  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "us-central1"
}

provider "aws" {
  version = ">= 1.2, < 1.12"
  region  = "us-west-2"
}
