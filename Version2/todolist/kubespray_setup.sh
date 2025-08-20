#!/bin/bash
set -e

# Copy inventory file
cp '/mnt/c/Users/olga/terraform/Version4/Creating-vms/inventory.ini' '/home/olga/kubespray/inventory/mycluster/inventory.ini'

# Install python and run kubespray
cd ~/kubespray
source venv/bin/activate

ansible all -m raw -a "sudo apt update && sudo apt install -y software-properties-common && sudo add-apt-repository -y ppa:deadsnakes/ppa && sudo apt install -y python3.8 python3.8-distutils" -i inventory/mycluster/inventory.ini
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml

CONTROL_IP=$(grep -A1 '\[kube_control_plane\]' inventory/mycluster/inventory.ini | tail -n1 | awk '{print $1}' | cut -d'=' -f2)

# Copy kube config 
ssh -o StrictHostKeyChecking=no -i ~/vagrant_key ubuntu@$CONTROL_IP 'sudo cat /etc/kubernetes/admin.conf' > '/mnt/c/Users/olga/.kube/config'