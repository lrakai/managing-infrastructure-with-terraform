# managing-infrastructure-with-terraform

Resources used in the production of my "Managing Infrastructure With Terraform" course on [Cloud Academy](https://cloudacademy.com/cloud-trainers/logan-rakai/).

![Dependency Graph](https://github.com/lrakai/managing-infrastructure-with-terraform/blob/master/src/5-gcp-demo/two-tier/graph.png?raw=true)

## Notes on the GCP Demo

The passwords for the Cloud SQL database and GKE cluster have not been committed to version control. As a best practice, you should avoid checking sensitive information into version control.

One way to set the variables is to create a terraform.tfvars file in the `src/5-gcp-demo` directory with the following contents:

```hcl
sql_pass = "<Insert Cloud SQL Password>"

gke_master_pass = "<Insert GKE Password>"

```
