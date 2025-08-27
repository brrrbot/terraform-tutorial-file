provider "aws" {
  region = "ap-southeast-2"
}

module "ec2" {
  source = "./ec2"
  for_each = toset(["dev","prod","test"]) # Creating 3 EC2 instances
}