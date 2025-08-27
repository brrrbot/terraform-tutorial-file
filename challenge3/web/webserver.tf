resource "aws_instance" "web" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"
  security_groups = [module.security_group.security_group_name]
  user_data = file("./web/server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

module "security_group" {
  source = "./security"
}

module "eip" {
  source = "./eip"
  instance_id = aws_instance.web.id
}

output "public_ip" {
  value = module.eip.eip
}