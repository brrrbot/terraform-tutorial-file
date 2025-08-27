provider "aws" {
  region = "ap-southeast-2"
}

variable "vpcname" {
  type = string
  default = "myvpc"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "myList" {
  type = list(string)
  default = [ "hello", "world" ]
}

variable "myMap" {
  type = map
  default = {
    hello = "world",
    math = "bad",
  }
}

variable "inputName" {
  type = string
  description = "name of vpc: "
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      # Name = var.vpcname
      # Name = var.myList[0]
      # Name = var.myMap["hello"]
      name = var.inputName
    }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}

variable "myTuple" {
  type = tuple([ string,number,string ])
  default = [ "cat", 1, "dog" ]
}

variable "myObject" {
  type = object({
    name = string,
    port = list(number),
  })
  default = {
    name = "terraform"
    port = [ 22, 25, 80 ]
  }
}