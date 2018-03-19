# Cloud SQL outputs
output "master_instance_sql_ipv4" {
  value       = "${google_sql_database_instance.sql_master.ip_address.0.ip_address}"
  description = "The IPv4 address assigned for master"
}

# GKE outputs
output "endpoint" {
  value       = "${google_container_cluster.primary.endpoint}"
  description = "Endpoint for accessing the master node"
}

# k8s outputs
output "lb_ip" {
  value       = "${kubernetes_service.wordpress.load_balancer_ingress.0.ip}"
  description = "IP address of the WordPress frontend load balancer"
}
