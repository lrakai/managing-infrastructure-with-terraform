provider "google" {
  /* GCP credentials set with
     GOOGLE_CREDENTIALS environment variable */

  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "us-central1"
}

# Image for the instance to use
variable "image" {
  default = "debian-cloud/debian-8"
}

resource "google_compute_instance" "server" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["team-a", "demo"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    network = "default"
  }
}
