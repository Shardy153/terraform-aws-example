provider "aws" {
    region       = "${var.region_name}"
    version      = "~> 1.24"
}

resource "aws_vpc" "vpc" {
  cidr_block            = "${var.cidr_block}"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags {
      Name = "VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Public Subnet"
  }
}

resource "aws_key_pair" "public_key" {
  key_name   = "public-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQChV1MDZ8wNP7vVHk4zvtedxmielv8iBoH441NSKljYfn1WN6VJ6CBJqQwdmzYwEH+aMZ2krPpM4knIw0n5uTmAgRmkmiwyqePY0O5Oz8kPqQtxX2P9P1s0FFBrF3zCyJnfKdEs73IiHQQ3LoBizkTb4Nih3Su9kT8/6eI+YX2vR9UAnEsTy5iD0zIiPV5mGUdC5Et7HCD0FAzJ+l36t1cqmS9RTfOjsC81nZbA5waCsaxvnE6ntL6MZvpCJUWtFNlUEPfAUxdnNuTBndgvBCVrm/Ui9f+fmnBp6bt2TlRnVKMrRO1/3ITCL2SHnv8l2FiECoEyj6b7KGI9joegDYeGW5WoNPekiraiJU/dnYfG2RvkRFd4aNR88fd3FjIy0UH6X3JR2PTctx40ncxDKXVbNSyMPm2svuYrQXmAQ7QYCHYUVBJK4lD4FrXRVhwPbLRqk4QNiJV5kRdAI12LgZczPTVcdIDsWNIvJN8bdaDbuvWTvtYxRthTS5Eqgg+A5iDIxkp9klRgvW8rCPBvIcLHfUVjRPDv8x3oWo7dZglYKmkN6qiB2+A21iyd+9LK4N44P+7Bp0LddLCdlfIKoyiaLkCw9XDhnl9pqlJOrQ8J5WKIlrDgIwlbWeGqmuJWQXQQvC8XWv/nOhqNqEia4+gHqXMytgP20HnA1dgH2pIS1Q== vipul@appperfect.com"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "VPC internet gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Private Subnet"
  }
}

resource "aws_key_pair" "private_key" {
  key_name   = "private-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNy4uX9f3AJWs577oDEcxDf9OzOk/Rpa+DxmtICxkzCP27rkvchg9Z2MsJ4T6hW7xY6yj1kI62lKh+tu7RBhN2+XQ4If1QbTdZ1kY4gY1YWZPGU7h1e4ESdnBTGk0KKz8RZZf0l/T5nytiIAWFFEXvSDnh8HMq184y6yGKgQmCUCpZqchugAA84CFQP6AwO8vqr2O6Q70sm6+0QVEmquyI9uoA3IRBJTt2MeD/1ZbAEiMdAeijS3h/kH8YXZvPwJkmRt5KRarkYfbxiTyfbCWLUhjBQYih5qRpzHjVRyM0E6GnJAJr4G3mmR0Ejh74Of+pIUyyqEZPUBQActgDTrI++4hwHWel34URiIdfLgICkBskxQLQAg+QSCVGfP2q3JPniduayrgTJ7/8RscGTAr1NzMJMBeizcWO5ZRaV3dhkTpKc3W7RZubtscSHnXbUg/pExNxw+Mrle84WNn9B+bhcOyitQYda9T5JlOiCGcDxdExyE9SmGOBkv9CTSpethfNdeEYzi314JnH1ioNUrEpvgB1xlgZO822F7OrxLsnFS0NYY8z00lRMF2NjqNpVdjAhVSILJMi/GC54l0u23wh8BFB8MDf5H7GfyxvETBNI7BGyotueE+A8QsKrxz1wpez+rLGTKyAO7o+62EH9PAT3lmvDKGjbOxrWENie7UAoQ== vipul@appperfect.com"
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.private_subnet.id}"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
      Name = "Private Route table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_security_group" "public_sg" {
  name          = "public-security-group"
  vpc_id        = "${aws_vpc.vpc.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "Public SG"
  }
}


resource "aws_security_group" "private_sg" {
  name              = "private-security-group"
  vpc_id            = "${aws_vpc.vpc.id}"

  ingress {
    protocol        = -1
    from_port       = 0
    to_port         = 0
    security_groups = ["${aws_security_group.public_sg.id}"]
  }

  egress {
    protocol        = -1
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "Private SG"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.public_sg.id}"]
  key_name                    = "${aws_key_pair.public_key.key_name}"
  tags {
    Name = "Bastion Machine"
  }
}

resource "aws_instance" "private_instance" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = false
  subnet_id                   = "${aws_subnet.private_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.private_sg.id}"]
  key_name                    = "${aws_key_pair.private_key.key_name}"
  tags {
    Name = "Private Machine"
  }
}
