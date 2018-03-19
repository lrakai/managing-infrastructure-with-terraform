variable "wordpress_version" {
  default = "4.7.3"
}

resource "kubernetes_secret" "mysql" {
  metadata {
    name = "mysql-pass"
  }

  data {
    password = "${var.sql_pass}"
  }
}

resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector {
      app  = "wordpress"
      tier = "${kubernetes_replication_controller.wordpress.spec.0.selector.tier}"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_persistent_volume_claim" "wordpress" {
  metadata {
    name = "wp-pv-claim"

    labels {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "20Gi"
      }
    }

    volume_name = "${kubernetes_persistent_volume.wordpress.metadata.0.name}"
  }
}

resource "kubernetes_replication_controller" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    selector {
      app  = "wordpress"
      tier = "frontend"
    }

    template {
      container {
        image = "wordpress:4.9.4-php5.6-apache"
        name  = "wordpress"

        env {
          name  = "WORDPRESS_DB_HOST"
          value = "${google_sql_database_instance.sql_master.ip_address.0.ip_address}"
        }

        env {
          name  = "WORDPRESS_DB_USER"
          value = "${var.sql_user}"
        }

        env {
          name = "WORDPRESS_DB_PASSWORD"

          value_from {
            secret_key_ref {
              name = "${kubernetes_secret.mysql.metadata.0.name}"
              key  = "password"
            }
          }
        }

        port {
          container_port = 80
          name           = "wordpress"
        }

        volume_mount {
          name       = "wordpress-persistent-storage"
          mount_path = "/var/www/html"
        }
      }

      volume {
        name = "wordpress-persistent-storage"

        persistent_volume_claim {
          claim_name = "${kubernetes_persistent_volume_claim.wordpress.metadata.0.name}"
        }
      }
    }
  }
}

resource "google_compute_disk" "wordpress" {
  name = "wordpress-frontend"
  type = "pd-ssd"
  size = 20
  zone = "${var.region}-a"
}

resource "kubernetes_persistent_volume" "wordpress" {
  metadata {
    name = "wordpress-pv"
  }

  spec {
    capacity {
      storage = "20Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      gce_persistent_disk {
        pd_name = "${google_compute_disk.wordpress.name}"
        fs_type = "ext4"
      }
    }
  }
}
