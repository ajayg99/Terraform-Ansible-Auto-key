resource "aws_security_group" "ec2-sg-ansible"{
    name = "ec2-sg-ansible"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "pk"{
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "ansible-key" {
  key_name   = "ansible-key"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_instance" "ec2-ansible" {
  count         = var.ec2-count
  ami           = var.ec2-type
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-ansible-slave-${count.index+1}"
  }
  key_name = "ansible-key"
  vpc_security_group_ids = [aws_security_group.ec2-sg-ansible.id]
}

resource "local_file" "ssh_key"{
  filename = "${aws_key_pair.ansible-key.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}

resource "null_resource" "out"{
  depends_on = [ local_file.ssh_key ]
  provisioner "local-exec"{
    command = "chmod 400 ${local_file.ssh_key.filename}"
  }
}