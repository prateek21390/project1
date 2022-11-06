
# Vpc creation
resource "aws_vpc" "projectvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

}


#Public subnet 1
resource "aws_subnet" "projectsubnet" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public"
  }
}

#Public sublet 2
resource "aws_subnet" "projectsubnet2" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public2"
  }
}

#Private subnet 1
resource "aws_subnet" "projectprivatesubnet" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
 tags = {
    Name = "Private"
  }

}

#private subnet 2
resource "aws_subnet" "projectprivatesubnet2" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
 tags = {
    Name = "Private2"
  }
}

#Private subnet 3 (Az-a)
resource "aws_subnet" "privatesubnet3-a" {
  vpc_id = "${aws_vpc.projectvpc.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
}

#Private subnet 3 (Az-b)
resource "aws_subnet" "privatesubnet3-b" {
  vpc_id = "${aws_vpc.projectvpc.id}"
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
}


#RDS DB Subnet group
resource "aws_db_subnet_group" "dbsubnet" {
  name = "db_subnet_group"
  subnet_ids = ["${aws_subnet.privatesubnet3-a.id}", "${aws_subnet.privatesubnet3-b.id}"]
}

#Creating RDS instance
resource "aws_db_instance" "dbinstance" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnet.name}"
  db_name                   = "mydatabase"
  username               = "admin"
  password               = "ttn12345"
  skip_final_snapshot    = true
  apply_immediately = true
}