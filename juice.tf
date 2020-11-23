resource "aws_instance" "juicebox" {
  ami                         = "ami-062f7200baf2fa504"
  instance_type               = "t2.micro"
  key_name                    = var.aws_keypair
  subnet_id                   = aws_subnet.public-a.id
  user_data                   = <<-EOF
                #!/bin/bash
                #Get IP
                local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
                #!/bin/bash
                yum update -y
                yum install -y docker
                service docker start
                docker pull bkimminich/juice-shop
                docker run -d -p 80:3000 bkimminich/juice-shop
                EOF
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.juiceshopsecgroup.id
  ]
  tags = {
    "Name" = "juiceshop"
  }
}