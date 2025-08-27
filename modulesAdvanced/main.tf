provider "aws" {
  region = "ap-southeast-2"
}

module "ec2module" {
  source = "./ec2"
  ec2name = "Name from module"
}

output "moduleOutput" {
  value = module.ec2module.instance_id
}