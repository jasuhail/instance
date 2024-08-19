# Internet VPC
resource "aws_vpc" "kube_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Kube"
  }
}

# Subnets
resource "aws_subnet" "kube_public-1" {
  vpc_id                  = aws_vpc.kube_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "Kube Public 1"
  }
}

resource "aws_subnet" "kube-public-2" {
  vpc_id                  = aws_vpc.kube_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "Kube Public 2"
  }
}

resource "aws_subnet" "kube-public-3" {
  vpc_id                  = aws_vpc.kube_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "Kube Public 3"
  }
}

resource "aws_subnet" "kube-private-1" {
  vpc_id                  = aws_vpc.kube_vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "Kube Private 1"
  }
}


# Internet GW
resource "aws_internet_gateway" "kube-gw" {
  vpc_id = aws_vpc.kube_vpc.id

  tags = {
    Name = "Kube IGW"
  }
}

# route tables
resource "aws_route_table" "kube-public" {
  vpc_id = aws_vpc.kube_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kube-gw.id
  }

  tags = {
    Name = "Kube Public 1"
  }
}

# route associations public
resource "aws_route_table_association" "kube-public-1-a" {
  subnet_id      = aws_subnet.kube_public-1.id
  route_table_id = aws_route_table.kube-public.id
}

resource "aws_route_table_association" "kube-public-2-a" {
  subnet_id      = aws_subnet.kube-public-2.id
  route_table_id = aws_route_table.kube-public.id
}

resource "aws_route_table_association" "kube-public-3-a" {
  subnet_id      = aws_subnet.kube-public-3.id
  route_table_id = aws_route_table.kube-public.id
}

resource "aws_eip" "kube_eip" {
  vpc      = true
  tags = {
    Name = "kube Elastic IP"
  }
}
