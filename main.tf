
terraform {
  backend "s3" {
    bucket         = "f5-payg-aws-cft-tf-env"
    key            = "f5-payg-aws-cft-tf-env.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "f5-payg-aws-cft-tf-env-state-lock"
  }
}

resource "aws_s3_bucket" "f5-payg-aws-cft-tf-env-s3" {
  bucket = "f5-payg-aws-cft-tf-env-s3"
  acl    = "private"

  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_object" "f5-payg-aws-cft-tf-env-s3-object" {
  key                    = "f5-payg-cft.json"
  bucket                 = aws_s3_bucket.f5-payg-aws-cft-tf-env-s3.id
  source                 = "f5-payg-cft.json"
  server_side_encryption = "aws:kms"
}


resource "aws_vpc" "f5-payg-vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main-vpc-f5-payg"
  }

}

resource "aws_subnet" "f5-management-a" {
  vpc_id                  = aws_vpc.f5-payg-vpc.id
  cidr_block              = "10.10.101.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability-zones
  tags = {
    Name = "management"
  }
}


resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.f5-payg-vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability-zones

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id                  = aws_vpc.f5-payg-vpc.id
  cidr_block              = "10.10.100.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability-zones
  tags = {
    Name = "private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.f5-payg-vpc.id

}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.f5-payg-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}

resource "aws_main_route_table_association" "association-subnet" {
  vpc_id         = aws_vpc.f5-payg-vpc.id
  route_table_id = aws_route_table.rt1.id
}



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
}