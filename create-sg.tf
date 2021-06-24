resource "aws_security_group" "eks-sg" {
  name        = "eks-sg"
  description = "HTTP from internet"
  vpc_id      = aws_vpc.VPC_obligatorio.id

  ingress {
    description      = "HTTP from internet"
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
    Name = "eks-sg"
  }
}


resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.VPC_obligatorio.id

  ingress {
    description      = "mysql from kubernetes"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups      = [aws_security_group.eks-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}