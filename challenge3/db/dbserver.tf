resource "aws_instance" "db" {
  ami = "ami-093dc6859d9315726"
  instance_type = "t3.micro"

  tags = {
    Name = "DB Server"
  }
}

output "private_ip" {
  value = aws_instance.db.private_ip
}