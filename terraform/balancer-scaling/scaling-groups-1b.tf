# resource "aws_autoscaling_group" "nginx" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pusn_id, var.pusn_idb]
#   vpc_zone_identifier = [var.pusn_idb]

#   launch_configuration = var.nginx_config_id
#   tags = {
#     Name = "SMZ-nginx"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
#   autoscaling_group_name = aws_autoscaling_group.nginx.id
#   lb_target_group_arn    = aws_lb_target_group.nginx-tg.arn
# }

# resource "aws_autoscaling_group" "web" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.web_config_id
#   tags = {
#     Name = "SMZ-web"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_web" {
#   autoscaling_group_name = aws_autoscaling_group.web.id
#   lb_target_group_arn    = aws_lb_target_group.web-tg.arn
# }

# resource "aws_autoscaling_group" "auth" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.auth_config_id
#   tags = {
#     Name = "SMZ-auth"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_auth" {
#   autoscaling_group_name = aws_autoscaling_group.auth.id
#   lb_target_group_arn    = aws_lb_target_group.auth-tg.arn
# }

# resource "aws_autoscaling_group" "users" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.users_config_id
#   tags = {
#     Name = "SMZ-users"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_users" {
#   autoscaling_group_name = aws_autoscaling_group.users.id
#   lb_target_group_arn    = aws_lb_target_group.users-tg.arn
# }

# resource "aws_autoscaling_group" "todos" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.todos_config_id
#   tags = {
#     Name = "SMZ-todos"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_todos" {
#   autoscaling_group_name = aws_autoscaling_group.todos.id
#   lb_target_group_arn    = aws_lb_target_group.todos-tg.arn
# }

# resource "aws_autoscaling_group" "redis" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.redis_config_id
#   tags = {
#     Name = "SMZ-redis"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_redis" {
#   autoscaling_group_name = aws_autoscaling_group.redis.id
#   lb_target_group_arn    = aws_lb_target_group.redis-tg.arn
# }

# resource "aws_autoscaling_group" "log" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.log_config_id
#   tags = {
#     Name = "SMZ-log"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_log" {
#   autoscaling_group_name = aws_autoscaling_group.log.id
#   lb_target_group_arn    = aws_lb_target_group.log-tg.arn
# }

# resource "aws_autoscaling_group" "zipkin" {
#   # availability_zones = ["us-east-1a", "us-east-1b"]
#   desired_capacity   = 1
#   max_size           = 3
#   min_size           = 1
#   # vpc_zone_identifier = [var.pvsn_id, var.pvsn_idb]
#   vpc_zone_identifier = [var.pvsn_idb]

#   launch_configuration = var.zipkin_config_id
#   tags = {
#     Name = "SMZ-zipkin"
#   }
# }
# resource "aws_autoscaling_attachment" "asg_attachment_zipkin" {
#   autoscaling_group_name = aws_autoscaling_group.zipkin.id
#   lb_target_group_arn    = aws_lb_target_group.zipkin-tg.arn
# }