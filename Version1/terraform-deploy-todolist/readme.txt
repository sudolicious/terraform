Creating Todolist Application Infrastructure with Terraform

Description:
This project automates the deployment of the Todolist application using Terraform (provider terra-farm/virtualbox provider).

Infrastructure is created in several stages:
1. Creating virtual machines in VirtualBox
2. Setting up a Kubernetes cluster using Kubespray
3. Deploying the application to the Kubernetes cluster

Application Architecture:
- Frontend: React application
- Backend: Web service on Go
- Database: PostgreSQL
- Ingress: Nginx for incoming traffic

Requirements:
- Terraform v1.0+
- VirtualBox 6.0+
- WSL (Windows Subsystem for Linux)
- Kubespray
- Helm

Deployment Steps:

1. Clone the repository
   git clone https://github.com/sudolicious/terraform

2. Create virtual machines:
   cd creating-vms
   terraform init
   terraform apply

3. Set up Kubernetes and deploy the application:
   cd ../todolist
   terraform init
   terraform apply

Important files:
- creating-vms/main.tf: Terraform configuration for creating virtual machines and inventory file
- creating-vms/templates/inventory.tpl: Ansible inventory template
- creating-vms/variables.tf: configuration variables

- todolist/main.tf: configuration for deploying the Kubernetes cluster and application
- todolist/variables.tf: configuration variables
- backend/: Helm chart for the backend application
- frontend/: Helm chart for the frontend application

After successfully completing all stages, the application will be available at:
http://altenar-internship-2025.com/

Note: Ensure all dependencies are installed and WSL is properly configured before running.
