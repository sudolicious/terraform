output "vm_ips_list" {
  description = "IP addresses of all created VMs as list"
  value       = [for vm in virtualbox_vm.ubuntu-vm : vm.network_adapter[0].ipv4_address]
}

output "inventory_file" {
  description = "Path to the generated Ansible inventory file"
  value       = local_file.inventory.filename
}