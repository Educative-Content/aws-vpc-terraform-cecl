provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "my_pets_2022" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-pets-2022"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.my_pets_2022.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "SubnetA"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.my_pets_2022.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "SubnetB"
  }
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.my_pets_2022.id
  tags = {
    Name = "VPC_InternetGateway"
  }
}  

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.my_pets_2022.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }

  tags = {
    Name = "VPC_RouteTable"
  }
}
