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
resource "aws_subnet" "database-a" {
  vpc_id                  = aws_vpc.f5-payg-vpc.id
  cidr_block              = "10.10.200.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability-zones
  tags = {
    Name = "database"
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

