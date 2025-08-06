Terraform: 2 VMs in VirtualBox

This Terraform configuration creates 2 virtual machines in VirtualBox.

Requirements:
1. VirtualBox 6.0+ (https://www.virtualbox.org/)
2. Terraform 1.0+ (https://www.terraform.io/)

Quick Start:
1. Clone the repository:
   git clone git@github.com:sudolicious/terraform.git
   cd terraform

2. Initialize Terraform:
   terraform init

3. Review and modify variables in main.tf:
   - vm_count (default: 2)
   - vm_name (default: "terraform-vm")
   - vm_cpus (default: 2)
   - vm_memory (default: 2048) # in MB
   - os_image

4. Create the VMs:
   terraform plan
   terraform apply

5. Destroy when done:
   terraform destroy

Key Files:
- main.tf: VM configuration and outputs

Accessing VMs:
   Via SSH (if configured):
   ssh vagrant@<vm_ip_from_output>
