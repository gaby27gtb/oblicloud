resource "aws_db_instance" "dbobligatorio" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "dbobligatorio"
  username             = "ort"
  password             = "passwordort"
  skip_final_snapshot  = true
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_db.name

  maintenance_window      = "Sat:01:00-Sat:04:00"
  backup_window           = "00:00-00:50"
  backup_retention_period = 7
  apply_immediately = "true"
}

resource "aws_db_subnet_group" "subnet_db" {
  name       = "subnet_db"
  subnet_ids = [aws_subnet.vpc-subnet-us-east-1a.id, aws_subnet.vpc-subnet-us-east-1b.id]

  tags = {
    Name = "dbobligatorio"
  }
}

