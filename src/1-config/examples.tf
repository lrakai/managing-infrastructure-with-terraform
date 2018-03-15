resource "google_compute_disk" "default" {
  name = "example-disk"
  zone = "us-central1-a"
}

provider "google" {
  credentials = "${file("account.json")}"
  project     = "gcp-project-id"
  region      = "us-central1"
}

data "google_compute_address" "my_address" {
  name = "foobar"
}
