provider "aws" {
  region = "eu-west-2"
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis5.0"

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "min-replicas-to-write"
    value = "2"
  }
}

resource "aws_elasticache_replication_group" "example" {
  automatic_failover_enabled    = true
  availability_zones            = ["eu-west-2a", "eu-west-2b"]
  replication_group_id          = "redis-tf-rep-group-1"
  replication_group_description = "Redis Elasticache Replication Group"
  node_type                     = "cache.m4.large"
  number_cache_clusters         = 2
  parameter_group_name          = "cache-params"
  port                          = 6379

  lifecycle {
    ignore_changes = [number_cache_clusters]
  }
}

resource "aws_elasticache_cluster" "replica" {
  count = 1

  cluster_id           = "tf-rep-group-1-${count.index}"
  replication_group_id = aws_elasticache_replication_group.example.id
}
