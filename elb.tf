resource "aws_lb" "balanceador-publico" {
  name               = "balanceador-publico"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-ssh.id]
  subnets            = [aws_subnet.vpc-subnet-us-east-1a.id, aws_subnet.vpc-subnet-us-east-1b.id] 

  tags = {
    Name = "balanceador-publico"
  }
}
resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.balanceador-publico.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_nginx.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_nginx1" {
  target_group_arn = aws_lb_target_group.tg_nginx.arn
  target_id        = aws_instance.Servidor_Web_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_nginx2" {
  target_group_arn = aws_lb_target_group.tg_nginx.arn
  target_id        = aws_instance.Servidor_Web_2.id
  port             = 80
}

resource "aws_lb_target_group" "tg_nginx" {
  name     = "tgNginx"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.VPC_obligatorio.id
}
