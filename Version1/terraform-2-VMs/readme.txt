Terraform: 2 VMs in VirtualBox (provider terra-farm)

This Terraform configuration creates 2 virtual machines in VirtualBox.

Requirements:
1. VirtualBox (https://www.virtualbox.org/)
2. Terraform (https://www.terraform.io/)
3. Default Vagrant SSH key (download from: https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant)

Quick Start:
1. Clone the repository:
   git clone https://github.com/sudolicious/terraform/Version1

2. Download and install the default Vagrant SSH key:
   mkdir -p ~/.ssh
   curl -o ~/.ssh/vagrant https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant
   chmod 600 ~/.ssh/vagrant

3. Review and modify variables in variables.tf:
   - vm_count (default: 2)
   - vm_name (default: "terraform-vm")
   - vm_cpus (default: 2)
   - vm_memory (default: 2048) # in MB
   - os_image
   
4. Initialize Terraform:
   terraform init

5. Create the VMs:
   terraform plan
   terraform apply

6. Destroy when done:
   terraform destroy

Key Files:
- main.tf
- variables.tf

Accessing VMs:
Download the default Vagrant SSH key from the link above and use:
   ssh -i ~/.ssh/vagrant vagrant@<vm_ip_from_output>

Note: The default username and password for Vagrant boxes is "vagrant" and the SSH key authentication is required for access.
