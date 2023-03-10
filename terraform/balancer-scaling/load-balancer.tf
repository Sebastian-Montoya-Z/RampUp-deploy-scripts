resource "aws_lb" "SMZ-lb-internal" {
  name               = "SMZ-lb-internal"
  internal           = true
  load_balancer_type = "application"
  subnets            = [var.pvsn_id, var.pvsn_idb]
  security_groups    = [var.pvsg_id]
  tags = {
    Name = "SMZ-lb-internal"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
  resource "aws_lb_listener" "web-listener" {
    load_balancer_arn = aws_lb.SMZ-lb-internal.arn 
    port     = 8080
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.web-tg.arn
    }
  }
    resource "aws_lb_listener" "auth-listener" {
    load_balancer_arn = aws_lb.SMZ-lb-internal.arn 
    port     = 8081
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.auth-tg.arn
    }
  }
    resource "aws_lb_listener" "users-listener" {
    load_balancer_arn = aws_lb.SMZ-lb-internal.arn 
    port     = 8083
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.users-tg.arn
    }
  }
    resource "aws_lb_listener" "todos-listener" {
    load_balancer_arn = aws_lb.SMZ-lb-internal.arn 
    port     = 8082
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.todos-tg.arn
    }
  }
    resource "aws_lb_listener" "zipkin-listener" {
    load_balancer_arn = aws_lb.SMZ-lb-internal.arn 
    port     = 9411
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.zipkin-tg.arn
    }
  }

output "lb_ip" {
    value = aws_lb.SMZ-lb-internal.dns_name
}

resource "aws_lb" "SMZ-lb-external" {
  name               = "SMZ-lb-external"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.pusn_id, var.pusn_idb]

    tags = {
    Name = "SMZ-lb-external"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
  resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.SMZ-lb-external.arn 
    port     = 8009
    protocol = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.nginx-tg.arn
    }
  }

  resource "aws_lb" "SMZ-nlb-redis" {
  name               = "SMZ-nlb-redis"
  internal           = true
  load_balancer_type = "network"
  subnets            = [var.pusn_id, var.pusn_idb]

    tags = {
    Name = "SMZ-nlb-redis"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
  resource "aws_lb_listener" "redis-listener" {
    load_balancer_arn = aws_lb.SMZ-nlb-redis.arn 
    port     = 6379
    protocol = "TCP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.redis-tg.arn
    }
  }
  output "nlb_ip" {
    value = aws_lb.SMZ-nlb-redis.dns_name
}