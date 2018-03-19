terraform {
  backend "gcs" {
    bucket = "ca-demo-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "${var.region}"
}

provider "kubernetes" {
  version = "1.0.1"

  host     = "${google_container_cluster.primary.endpoint}"
  username = "${google_container_cluster.primary.master_auth.0.username}"
  password = "${google_container_cluster.primary.master_auth.0.password}"

  client_certificate     = "${base64decode(google_container_cluster.primary.master_auth.0.client_certificate)}"
  client_key             = "${base64decode(google_container_cluster.primary.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
}
