provider "aws" {
  region = var.region
}

resource "aws_instance" "demo" {
  ami                    = data.aws_ami.main_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.demo.key_name
  vpc_security_group_ids = [aws_security_group.demo.id]
  root_block_device {
    delete_on_termination = true
  }

  provisioner "file" {
    source      = "awx"
    destination = "/tmp/"
  }
  connection {
    type        = "ssh"
    user        = var.instance_username
    private_key = file(var.path_to_private_key)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.instance_username
      private_key = file(var.path_to_private_key)
      host        = self.public_ip
    }

    inline = [
      "sudo yum install -y git wget",
      "sudo yum install -y epel-release && sudo yum install -y ansible",
      "sudo yum check-update -y",
      "sudo curl -fsSL https://get.docker.com/ | sh",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo yum install -y python3",
      "sudo yum install -y libselinux-python3",
      "sudo pip3 install requests",
      "sudo pip3 install compose",
      "sudo pip3 install docker",
      "sudo pip3 install docker-compose",
      "sudo ansible-playbook -i /tmp/awx/installer/inventory /tmp/awx/installer/install.yml"
    ]
  }

  tags = {
    Name      = "demo"
    Project   = var.project_tag
    Infra     = var.infra_tag
    ManagedBy = var.managedby_tag
    Env       = var.env_tag
  }
}
data "aws_ami" "main_ami" {
  owners      = ["aws-marketplace"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }
}     