provider "aws" {
  region = "ap-southeast-2"
}

variable "environment" {
  type = string
}

resource "aws_instance" "ec2" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"
  count = var.environment == "test" ? 1 : 0
}