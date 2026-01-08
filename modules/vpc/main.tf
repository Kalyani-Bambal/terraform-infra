resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = merge(
        var.tags,
        {
            name = "${var.env}-vpc"
        }
    )

}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    name = "${var.env}-igw"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.env}-public-${count.index+1}"
    tier = "public"
  }
}