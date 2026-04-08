resource "aws_lb" "lb" {
  name               = format("%s-lb", var.prefix)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = module.vpc.public_subnets

  tags = {
    Name = format("%s-lb", var.prefix)
  }
}

resource "aws_lb_target_group" "tg" {
  name        = format("%s-tg", var.prefix)
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200,302"
    path                = "/users"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_security_group" "lb_sg" {
  name        = format("%s-lb-sg", var.prefix)
  description = "Security group for Load Balancer"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = format("%s-lb-sg", var.prefix)
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_ingress" {
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "lb_ingress_8000" {
  security_group_id            = aws_security_group.lb_sg.id
  referenced_security_group_id = aws_security_group.lb_sg.id

  from_port   = 8000
  ip_protocol = "tcp"
  to_port     = 8000
}

resource "aws_vpc_security_group_egress_rule" "lb_egress" {
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
