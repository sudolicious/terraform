Creating Todolist Application Infrastructure with Terraform, stage 2

Description:
This project automates the deployment of the Todolist application using Helm

Application Architecture:
- Frontend: React application
- Backend: Web service on Go
- Database: PostgreSQL
- Ingress: Nginx for incoming traffic

Requirements:
- Terraform v1.0+
- VirtualBox 6.0+
- Kubernetes Cluster

Deploying the application to the Kubernetes cluster:

1. Clone the repository
   git clone https://github.com/sudolicious/terraform

2. Create password secret in k8s-cluster
   kubectl create secret generic postgres-secret --from-literal=POSTGRES_PASSWORD=yoursecretpassword

3. Deploy the application to ready k8s-cluster:
   cd Version1/todolist
   terraform init
   terraform plan
   terraform apply

Important files:
- todolist/main.tf: configuration for deploying the application with Helm
- todolist/variables.tf: configuration variables
- backend/: Helm chart for the backend application
- frontend/: Helm chart for the frontend application

After successfully completing all stages, the application will be available at:
http://altenar-internship-2025.com/

Note: Ensure k8s-cluster is ready before running.
