variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}

variable "vm_name_prefix" {
  description = "Prefix for VM names"
  type        = string
  default     = "k8s-node"
}

variable "vm_image" {
  description = "URL of the VM image"
  type        = string
  default     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
}

variable "vm_cpus" {
  description = "Number of CPUs per VM"
  type        = number
  default     = 4
}

variable "vm_memory" {
  description = "Memory size per VM"
  type        = string
  default     = "8096 MiB"
}

variable "network_type" {
  description = "Type of network adapter"
  type        = string
  default     = "bridged"
}

variable "host_interface" {
  description = "Host network interface for bridged mode"
  type        = string
  default     = "Qualcomm WCN685x Wi-Fi 6E Dual Band Simultaneous (DBS) WiFiCx Network Adapter"
}
