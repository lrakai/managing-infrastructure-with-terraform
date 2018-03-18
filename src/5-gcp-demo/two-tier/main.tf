terraform {
  backend "gcs" {
    bucket = "ca-demo-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "us-central1"
}

provider "kubernetes" {
  version = "1.0.1"

  host     = "${google_container_cluster.primary.endpoint}"
  username = "${google_container_cluster.primary.master_auth.username}"
  password = "${google_container_cluster.primary.master_auth.password}"

  client_certificate     = "${google_container_cluster.primary.master_auth.0.client_certificate}"
  client_key             = "${google_container_cluster.primary.master_auth.0.client_key}"
  cluster_ca_certificate = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
