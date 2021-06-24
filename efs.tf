##Creamos el file system
resource "aws_efs_file_system" "documentos-fs" {
  creation_token = "documentos-fs"
  
  tags = {
    Name = "documentos-fs"
  }
}

##Creamos el mount target
resource "aws_efs_mount_target" "documentos-1a" {
  file_system_id = aws_efs_file_system.documentos-fs.id
  subnet_id      = aws_subnet.vpc-subnet-us-east-1a.id
  security_groups      = [aws_security_group.eks-sg.id]
}

resource "aws_efs_mount_target" "documentos-1b" {
  file_system_id = aws_efs_file_system.documentos-fs.id
  subnet_id      = aws_subnet.vpc-subnet-us-east-1b.id
  security_groups      = [aws_security_group.eks-sg.id]
}
