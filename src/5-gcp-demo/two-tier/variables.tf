# GKE variables
var "num_gke_nodes" {
  type        = "number"
  description = "Number of nodes in the GKE cluster"
}

var "gke_master_user" {
  default     = "k8s_admin"
  description = "Username to authenticate with the k8s master"
}

var "gke_master_pass" {
  default     = "1_Cloud_Academy!"
  description = "Username to authenticate with the k8s master"
}

var "gke_node_machine_type" {
  default     = "n1-standard-1"
  description = "Machine type of GKE nodes"
}
