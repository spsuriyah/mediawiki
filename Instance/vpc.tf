
resource "aws_vpc" "DevOps-VPC" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "DevOps-VPC"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = "${aws_vpc.DevOps-VPC.id}"
  cidr_block = "${var.public_subnets_cidr}"
  availability_zone = "${var.azs}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "DevOps-Public-Subnet}"
  }
}

resource "aws_internet_gateway" "DevOps-IGW" {
  vpc_id = "${aws_vpc.DevOps-VPC.id}"
  tags = {
    Name = "DevOps-IGW"
  }
}

# Create  Public Route table and provide Internet access via Internet Gateway
resource "aws_route_table" "DevOps-Public-RT" {
    vpc_id      = "${aws_vpc.DevOps-VPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.DevOps-IGW.id}"  
  }
  tags = {
    Name = "DevOps-Public-RT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.DevOps-Public-RT.id}"
}

resource "aws_security_group" "DevOps-EC2-SG" {
  name        = "DevOps-EC2-SG"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.DevOps-VPC.id}"
  tags = {
    Name = "DevOps-EC2-SG"
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}