# Cloud SQL outputs
output "master_instance_sql_ipv4" {
  value       = "${google_sql_database_instance.sql_master.ip_address.0.ip_address}"
  description = "The IPv4 address assigned for master"
}

# GKE outputs
output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
