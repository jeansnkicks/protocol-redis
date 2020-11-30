provider "aws" {
  region = "eu-west-2"
}

data "aws_security_group" "k8snodes" {
  filter {
    name = "description"
    values = ["Security group for nodes"]
  }
}

module "vpc" {
  source = "cloudposse/vpc"
  versioin = "0.17.0"

  cidr_block = "172.16.0.0/16"

  context = module.this.context

  # resulting fields:
  #vpc_id
  #igw_id
  #vpc_cidr_block
  #vpc_default_security_group_id
}

module "subnets" {
  source = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.30.0"

  availability_zones   = ["eu-west-2a", "eu-west-2b"]
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context

  # resulting fields:
  #private_subnet_ids
}

module "elasticache-redis" {
  source  = "cloudposse/elasticache-redis/aws"
  version = "0.25.0"

  # VPC Networking
  vpc_id                           = module.vpc.vpc_id
  allowed_security_groups          = [module.vpc.vpc_default_security_group_id,data.aws_security_group.k8snodes.id]
  subnets                          = module.subnets.private_subnet_ids

  # Do not use DNS
  zone_id                          = ""

  # Not sure if we need to set both of these
  engine_version                   = "6.x"
  family                           = "redis6.x"

  # Nodes
  availability_zones               = ["eu-west-2a", "eu-west-2b"]
  cluster_size                     = 2
  instance_type                    = "cache.m4.large"

  # AWS flags
  apply_immediately                = true

  # Redis Flags
  automatic_failover_enabled       = true
  at_rest_encryption_enabled       = true
  transit_encryption_enabled       = true
  cloudwatch_metric_alarms_enabled = true

  parameter = [
    {
      name  = "activerehashing"
      value = "yes"
    },
    {
      name  = "min-replicas-to-write"
      value = "2"
    }
  ]

}
