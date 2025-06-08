provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "minimal_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "minimal-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.minimal_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "minimal-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.minimal_vpc.id

  tags = {
    Name = "minimal-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.minimal_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "minimal-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
