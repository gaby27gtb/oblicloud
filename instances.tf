resource "aws_instance" "Servidor_Web_1" {
    ami                 = var.ami
    instance_type       = var.instance_type
    key_name            = var.key_name
    vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]
    private_ip = "172.16.1.10"
    subnet_id = aws_subnet.vpc-subnet-us-east-1a.id
    tags = {
        Name        = "Servidor_Web_1"
        terraform   = "True"
    }
}

resource "aws_instance" "Servidor_Web_2" {
    ami                 = var.ami
    instance_type       = var.instance_type
    key_name            = var.key_name
    vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]
    private_ip = "172.16.2.10"
    subnet_id = aws_subnet.vpc-subnet-us-east-1b.id
    tags = {
        Name        = "Servidor_Web_2"
        terraform   = "True"
    }
}



resource "aws_db_instance" "db-relacional" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "db_relacional"
  username             = "user"
  password             = "password"
  skip_final_snapshot  = true
  availability_zone = "us-east-1c"
  vpc_security_group_ids = [aws_security_group.allow-mysql.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_db.name
}

resource "aws_db_subnet_group" "subnet_db" {
  name       = "subnet_db"
  subnet_ids = [aws_subnet.vpc-subnet-us-east-1c.id, aws_subnet.vpc-subnet-us-east-1b.id]

  tags = {
    Name = "My DB subnet group"
  }
}