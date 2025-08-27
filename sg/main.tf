provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"
  security_groups = [ aws_security_group.webtraffic.name ]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
}

# Dynamic block
variable "ingressrules" {
  type = list(number)
  default = [ 80,443 ]
}

variable "egressrules" {
  type = list(number)
  default = [ 80,443,25,3306,53,8080 ]
}

# Ports lists
# 25 -> SMTP
# 3306 -> MYSQL database
# 53 -> DNS server
# 8080 -> Testing port