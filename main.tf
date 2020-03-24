provider "aws" {
  profile = "default"
  region  = var.aws_region
}

data "aws_ami" "aws_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# This uses the default VPC. It will NOT delete it on destroy
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow-ssh" {
  name        = "nginx-demo"
  description = "Allow ports for nginx demo"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.aws_linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
}

output "aws_public_ip" {
  value = aws_instance.nginx.public_dns
}