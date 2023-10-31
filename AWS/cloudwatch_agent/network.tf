resource "aws_vpc" "tf_study_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    "Name" = "tf_study_vpc"
  }
}

# Subnet
resource "aws_subnet" "tf_study_subnet-public1" {
  vpc_id = aws_vpc.tf_study_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "tf_study_subnet-public1"
  }
}

resource "aws_route_table_association" "public1_rt_asso" {
  subnet_id = aws_subnet.tf_study_subnet-public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_internet_gateway" "tf_study-igw" {
  vpc_id = aws_vpc.tf_study_vpc.id
  tags = {
    "Name" = "tf_study-igw"
  }
}

# route table 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.tf_study_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_study-igw.id
  }
  tags = {
    "Name" = "public_rt"
  }
}