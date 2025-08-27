provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "db" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"

  tags = {
    Name = "DB Server"
  }
}

resource "aws_instance" "web" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"
  security_groups = [aws_security_group.webtraffic.name]
  user_data = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
}

variable "ingress" {
  type = list(number)
  default = [ 80,443 ]
}

variable "egress" {
  type = list(number)
  default = [ 80,443 ]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
}

output "privateip" {
  value = aws_instance.db.private_ip
}

output "publicip" {
  value = aws_eip.web_ip.public_ip
}