terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.securitygroup.id ]
  subnet_id = aws_subnet.subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "demo_example"
  }
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "example"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.cidr_block1
  availability_zone = "us-east-2a"

  tags = {
    Name = "example"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.myvpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "securitygroup" {
  # ... other configuration ...
  name = var.sg
  vpc_id = aws_vpc.myvpc.id
  ingress{
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress{
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}