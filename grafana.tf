data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "graphite_grafana" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = var.aws_keypair
  monitoring                  = true
  subnet_id                   = aws_subnet.public-a.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.grafanasecgroup.id
  ]
  # build user_data file from template
  user_data = file("grafana.sh")

  tags = {
    "Name" = "grafana"
  }
}