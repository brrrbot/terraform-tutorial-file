provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.ec2.id
}

output "eip" {
  value = aws_eip.elasticeip.public_ip
}