# Terraform-Ansible-Auto-key
Create EC2 instances with terraform(Infrastructure Management) and utilize ansible(configuration Management) playbook to copy localhost keys to EC2 instances


Update the variables.tf for EC2 instance type and number of instance. The sg ingress allows only ssh traffic and egress allows all traffic from the instance. 


Terraform  (Ansible.tf)
1. terraform init
2. terraform plan
3. terraform apply --auto-approve
4. update the ip from terraform output onto inventory

Ansible (automate-key.yaml)
1. export ANSIBLE_HOST_KEY_CHECKING=False
2. ansible-playbook automate-key.yaml -i inventory --user ubuntu --key-file ansible-key.pem  

