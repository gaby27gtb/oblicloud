resource "aws_security_group" "allow-ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.VPC_obligatorio.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_security_group" "allow-http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.VPC_obligatorio.id

  ingress {
    description      = "http from public"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-http"
  }
}

resource "aws_security_group" "allow-mysql" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.VPC_obligatorio.id

  ingress {
    description      = "mysql from public"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-mysql"
  }
}