output "ec2-ansible-ip" {
  value = aws_instance.ec2-ansible[*].public_ip
}