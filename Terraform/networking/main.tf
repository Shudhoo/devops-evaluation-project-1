# This is networking folder which creates a VPC, IGW, Subnets, Route-Tabels..
# This are the variables that are pass to the below resources
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}


# This is VPC creation
resource "aws_vpc" "project-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "project-vpc"
  }
}

output "project-vpc-id" {
  value = aws_vpc.project-vpc.id
}

# This is IGW for created VPC
resource "aws_internet_gateway" "project-vpc-igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "project-vpc-igw"
  }
}

# This is Public-Subnet within VPC
resource "aws_subnet" "project-public-subnet" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "project-public-subnet"
  }
}

output "project-public-subnet-id" {
  value = aws_subnet.project-public-subnet.id
}

# This is Route-Table
resource "aws_route_table" "project-route-table" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-vpc-igw.id
  }
}

# This is Route-Table-Association
resource "aws_route_table_association" "project-route-table-association" {
  subnet_id = aws_subnet.project-public-subnet.id
  route_table_id = aws_route_table.project-route-table.id
}

