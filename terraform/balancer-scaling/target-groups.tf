resource "aws_lb_target_group" "nginx-tg" {
  name        = "nginx-tg"
  port        = 8009
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "nginx-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "web-tg" {
  name        = "web-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "web-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "auth-tg" {
  name        = "auth-tg"
  port        = 8081
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "auth-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "users-tg" {
  name        = "users-tg"
  port        = 8083
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "users-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "todos-tg" {
  name        = "todos-tg"
  port        = 8082
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "todos-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "redis-tg" {
  name        = "redis-tg"
  port        = 6379
  protocol    = "TCP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "redis-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "log-tg" {
  name        = "log-tg"
  port        = 8085
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "log-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_lb_target_group" "zipkin-tg" {
  name        = "zipkin-tg"
  port        = 9411
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "zipkin-tg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}