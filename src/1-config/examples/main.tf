resource "google_compute_disk" "default" {
  name = "example-disk"
  zone = "us-central1-a"
}

provider "google" {
  credentials = "${file("account.json")}"
  project     = "gcp-project-id"
  region      = "us-central1"
}

data "google_compute_address" "static_address" {
  name = "example-address"
}

variable "environment_tag" {
  type        = "string"
  default     = "staging"
  description = "Value of the infrastructure environment tag"
}

output "cluster_endpoint" {
  value = "${google_container_cluster.cluster.endpoint}"
}
