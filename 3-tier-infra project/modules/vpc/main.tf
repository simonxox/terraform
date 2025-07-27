
resource "aws_vpc" "three_tier" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = true
  tags = {
    Name = each.value["name"]
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]
  tags = {
    Name = each.value["name"]
  }
}
