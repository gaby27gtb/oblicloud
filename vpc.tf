resource "aws_vpc" "VPC_obligatorio" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_internet_gateway" "ig_obligatorio" {
  vpc_id = aws_vpc.VPC_obligatorio.id
}

resource "aws_default_route_table" "obligatorio-rt" {
  default_route_table_id = aws_vpc.VPC_obligatorio.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_obligatorio.id
  }

  tags = {
    Name = "Salida a internet"
  }
}

resource "aws_subnet" "vpc-subnet-us-east-1a" {
  vpc_id     = aws_vpc.VPC_obligatorio.id
  cidr_block = "172.16.1.0/24"
  availability_zone = var.az-1a
  map_public_ip_on_launch = true
  tags = {
    Name = "VPC US-East-1a"
    resource = "kubernetes.io/cluster/app-cluster"
  }
}

resource "aws_subnet" "vpc-subnet-us-east-1b" {
  vpc_id     = aws_vpc.VPC_obligatorio.id
  cidr_block = "172.16.2.0/24"
  availability_zone = var.az-1b
  map_public_ip_on_launch = true
  tags = {
    Name = "VPC US-east-1b"
    resource = "kubernetes.io/cluster/app-cluster"
  }
}
