terraform {

  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1" 
    }
  }
}

# Настройка провайдера
provider "virtualbox" {}

# Создание ВМ
resource "virtualbox_vm" "ubuntu-vm" {

  count  = 2
  name   = "k8s-node-${count.index}"
  image = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus   = 2
  memory = "4096 MiB"

# Настройка сети
  network_adapter {

    type = "bridged"
    host_interface = "Qualcomm WCN685x Wi-Fi 6E Dual Band Simultaneous (DBS) WiFiCx Network Adapter"
  }
}


# Вывод IP-адреса ВМ
output "vm_ip" {
  value = {
    for idx, vm in virtualbox_vm.ubuntu-vm : 
    "vm_${idx}" => vm.network_adapter.0.ipv4_address
  }
}
