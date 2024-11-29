1. Terraform Configuration
Terraform will provision the necessary GCP infrastructure, including a Kubernetes Engine (GKE) cluster.
File: main.tf

File: variables.tf

Steps to Apply Terraform
Initialize and deploy infrastructure:

terraform init
terraform apply

Save the kubeconfig output to a file (e.g., ~/.kube/config) to connect to the GKE cluster.

2. Kubernetes Deployment Files
File: deployment.yaml
File: service.yaml


3. Prometheus Monitoring Configuration
File: prometheus-config.yaml


File: prometheus-deployment.yaml


4. Dockerfile
File: Dockerfile

Sample Static Page (index.html)


5. Documentation
Deployment Steps
Provision Infrastructure with Terraform
Install Terraform and configure Google Cloud CLI (gcloud).
Run the following commands:
bash
Copy code
terraform init
terraform apply

Save the kubeconfig output to configure kubectl:

export KUBECONFIG=~/.kube/config


Build and Push Docker Image
Authenticate Docker with Google Container Registry (GCR):
gcloud auth configure-docker

Build the Docker image:

docker build -t gcr.io/your-gcp-project-id/static-web .

Push the image to GCR:

docker push gcr.io/your-gcp-project-id/static-web

Deploy Kubernetes Resources
Apply Kubernetes manifests:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f prometheus-deployment.yaml

Access the Application
Retrieve the external IP address of the LoadBalancer:

kubectl get svc

Open the IP address in a browser to view the application.
Monitor with Prometheus
Access the Prometheus dashboard:

kubectl port-forward deployment/prometheus 9090

Open http://localhost:9090 in a browser to view metrics.
