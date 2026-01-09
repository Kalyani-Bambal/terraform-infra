resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

    tags = merge(
       var.tags, 
       {
    Name = "${var.env}-vpc"
  }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = var.azs[count.index]
  
  tags = {
    Name = "${var.env}-private-${count.index+1}" 
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "${var.env}-nat"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = {for idx, subnet in aws_subnet.public : idx => subnet}
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = {for idx, subnet in aws_subnet.private : idx => subnet}
  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
}