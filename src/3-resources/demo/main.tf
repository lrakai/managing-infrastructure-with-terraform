provider "google" {
  version = "~> 1.7"
  project = "cloud-academy-terraform"
  region  = "us-central1"
}

resource "google_compute_disk" "default" {
  count = 3
  name  = "test-disk-${count.index}"
  type  = "pd-ssd"
  image = "debian-8-jessie-v20170523"
  zone  = "us-central1-a"

  provisioner "local-exec" {
    command = "echo disk ${count.index}: ${self.self_link} >> disk_urls.txt"
  }
}
