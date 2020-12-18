

resource "aws_security_group" "juiceshopsecgroup" {
  name   = "juiceshopsecgroup"
  vpc_id = aws_vpc.f5-payg-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.restrictedSrcAddress
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "grafanasecgroup"
  }
}

resource "aws_security_group" "grafanasecgroup" {
  name   = "grafanasecgroup"
  vpc_id = aws_vpc.f5-payg-vpc.id

  ingress {
    from_port   = 80
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
      ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }

  ingress {
    from_port   = 2003
    to_port     = 2004
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
  ingress {
    from_port   = 2023
    to_port     = 2024
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
  ingress {
    from_port   = 8125
    to_port     = 8125
    protocol    = "udp"
    cidr_blocks = var.restrictedSrcAddress
  }
  ingress {
    from_port   = 8126
    to_port     = 8126
    protocol    = "tcp"
    cidr_blocks = var.restrictedSrcAddress
  }
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.restrictedSrcAddress
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "grafanasecgroup"
  }
}
