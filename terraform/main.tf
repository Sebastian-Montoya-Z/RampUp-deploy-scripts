terraform { 
    required_providers {
        aws={
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
    source = "./networking"
}
module "security" {
    source = "./security"
    vpc_id = module.networking.vpc_id
    pusn_id = module.networking.pusn_id
    pusn_idb = module.networking.pusn_idb
    pvsn_id = module.networking.pvsn_id
    pvsn_idb = module.networking.pvsn_idb
    # pvsn_id = module.networking.pvsn_id
}
module "compute" {
    source = "./compute"
    vpc_id = module.networking.vpc_id
    pusn_id = module.networking.pusn_id
    pvsn_id = module.networking.pvsn_id
    pusg_id = module.security.pusg_id
    pvsg_id = module.security.pvsg_id
    lb_ip = module.balancer-scaling.lb_ip
    nlb_ip = module.balancer-scaling.nlb_ip
}
module "balancer-scaling" {
    source = "./balancer-scaling"
    vpc_id = module.networking.vpc_id
    pusn_id = module.networking.pusn_id
    pvsn_id = module.networking.pvsn_id
    pusn_idb = module.networking.pusn_idb
    pvsn_idb = module.networking.pvsn_idb
    pvsg_id = module.security.pvsg_id
    nginx_config_id = module.compute.nginx_config_id
    web_config_id = module.compute.web_config_id
    auth_config_id = module.compute.auth_config_id
    users_config_id = module.compute.users_config_id
    todos_config_id = module.compute.todos_config_id
    redis_config_id = module.compute.redis_config_id
    log_config_id = module.compute.log_config_id
    zipkin_config_id = module.compute.zipkin_config_id
}