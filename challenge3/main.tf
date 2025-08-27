provider "aws" {
  region = "ap-southeast-2"
}

module "dbserver" {
  source = "./db"
}

module "webserver" {
  source = "./web"
}

output "db_private_ip" {
  value = module.dbserver.private_ip
}

output "web_public_ip" {
  value = module.webserver.public_ip
}