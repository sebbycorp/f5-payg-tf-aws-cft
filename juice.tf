resource "aws_instance" "juicebox" {
  ami                         = "ami-062f7200baf2fa504"
  instance_type               = "t2.micro"
  key_name                    = var.aws_keypair
  subnet_id                   = aws_subnet.public-a.id
  user_data                   = file("juice.sh")
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.juiceshopsecgroup.id
  ]
  tags = {
    "Name" = "juiceshop"
  }
}