variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
}
variable "pusn_id" {
  description = "The ID of the public subnet"
}
variable "pvsn_id" {
  description = "The ID of the private subnet"
}
variable "pusn_idb" {
  description = "The ID of the public subnet"
}
variable "pvsn_idb" {
  description = "The ID of the private subnet"
}
variable "pvsg_id" {
  description = "The ID of the private security group"
}

variable "nginx_config_id" {
  description = "The ID of the public subnet"
}
variable "web_config_id" {
  description = "The ID of the public subnet"
}
variable "auth_config_id" {
  description = "The ID of the private subnet"
}
variable "users_config_id" {
  description = "The ID of the public security group"
}
variable "todos_config_id" {
  description = "The ID of the private security group"
}
variable "redis_config_id" {
  description = "The ID of the public subnet"
}
variable "log_config_id" {
  description = "The ID of the private subnet"
}
variable "zipkin_config_id" {
  description = "The ID of the public security group"
}