output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "private_instance_id" {
  value = aws_instance.private_ec2.id
}
