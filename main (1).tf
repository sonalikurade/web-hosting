provider "google" {
  project = "ace-vial-440912-k8"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster"
  location = var.region
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

output "kubeconfig" {
  value = <<EOL
apiVersion: v1
clusters:
- cluster:
    server: ${google_container_cluster.gke_cluster.endpoint}
    certificate-authority-data: ${google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate}
  name: gke-cluster
contexts:
- context:
    cluster: gke-cluster
    user: gke-cluster
  name: gke-cluster
current-context: gke-cluster
kind: Config
preferences: {}
users:
- name: gke-cluster
  user:
    token: ${google_container_cluster.gke_cluster.master_auth.0.client_certificate}
EOL
}
