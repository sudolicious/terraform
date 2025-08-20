[all]
%{ for idx, ip in vm_ips ~}
node${idx} ansible_host=${ip} ansible_user=vagrant ansible_ssh_private_key_file=/home/olga/vagrant_key ansible_python_interpreter=/usr/bin/python3
%{ endfor }

[kube_control_plane]
node0

[etcd]
node0

[kube_node]
%{ for idx, ip in vm_ips ~}
%{ if idx != 0 }node${idx}%{ endif }
%{ endfor }

[k8s_cluster:children]
kube_control_plane
kube_node
