
terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

#Settings of provider
provider "virtualbox" {}

resource "virtualbox_vm" "ubuntu-vm" {
  count  = var.vm_count
  name   = "${var.vm_name_prefix}-${count.index}"
  image  = var.vm_image
  cpus   = var.vm_cpus
  memory = var.vm_memory

  #Settings of network
  network_adapter {
    type           = var.network_type
    host_interface = var.host_interface
  }
}

#Output the ips
output "vm_ip" {
  value = {
    for idx, vm in virtualbox_vm.ubuntu-vm : 
    "vm_${idx}" => vm.network_adapter.0.ipv4_address
  }
}

# Parsing IPs
output "vm_ips" {
  description = "IP addresses of the created VMs"
  value       = [for vm in virtualbox_vm.ubuntu-vm : vm.network_adapter[0].ipv4_address]
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/templates/inventory.tpl", {
    vm_ips = [for vm in virtualbox_vm.ubuntu-vm : vm.network_adapter[0].ipv4_address]
  })
}