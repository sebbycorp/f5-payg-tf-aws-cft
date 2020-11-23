
output "vpc-id" {
  value = aws_vpc.f5-payg-vpc.id
}

output "vpc-public-a" {
  value = aws_subnet.public-a.cidr_block
}

output "vpc-public-a-id" {
  value = aws_subnet.public-a.id
}

output "vpc-private-a" {
  value = aws_subnet.private-a.cidr_block
}

output "vpc-private-a-id" {
  value = aws_subnet.private-a.id
}
output "sshKey" {
  value = var.aws_keypair
}
output "f5-managementSubnetAz1Address" {
  value = var.f5-managementSubnetAz1Address
}
output "f5-subnet1Az1Address" {
  value = var.f5-subnet1Az1Address
}

output "managementSubnetAz1" {
  value = aws_subnet.f5-management-a.id
}

output "restrictedSrcAddress" {
  value = "0.0.0.0/0"
}
output "juiceshop_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.juicebox.private_ip
}

