Creating Todolist Application Infrastructure with Terraform

Description:
This project automates the deployment of the Todolist application using Terraform (provider terra-farm/virtualbox).

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
- Default Vagrant SSH key (download from: https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant)

Deployment Steps:

1. Clone the repository:
   git clone https://github.com/sudolicious/terraform/Version2

2. Download and install the default Vagrant SSH key:
   mkdir -p ~/.ssh
   curl -o ~/.ssh/vagrant https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant
   chmod 600 ~/.ssh/vagrant

3. Create virtual machines:
   cd creating-vms
   terraform init
   terraform apply

4. Set up Kubernetes and deploy the application:
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

Note: 
1. Ensure all dependencies are installed and WSL is properly configured before running.
2. The default Vagrant SSH key is required for Kubespray to access the created VMs.
3. Make sure the SSH key has proper permissions (chmod 600).
