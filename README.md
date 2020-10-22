# protocol-redis
Terraform for persistent redis KV store for protocol

## Set up the Redis KV store on an AWS account

Install Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli

Clone the repo:
```
git clone https://github.com/kiva/protocol-redis
```

Set AWS profile (based on your `~/.aws/credentials` file):
```
export AWS_PROFILE=protocol-dev
```

Init Terraform for repo:
```
cd protocol-redis
terraform init
```

Apply the terraform config (you will be prompted with the plan before it executes):
```
terraform apply
```

NOTE: Known error:
```
Error: Error creating Elasticache Replication Group: CacheParameterGroupNotFound: CacheParameterGroup not found: cache-params
	status code: 404, request id: 1fc5439b-70be-41fd-bfbb-f14a6cab1587
```

If this occurs retry the `terraform apply`. It occurs because the replication
group requires the cache parameter group and the cache parameter group is
created but not ready when the replication group creation is attempted.

## Delete the Redis KV store

To tear down the redis:
```
terraform destroy
```

(You may have to run `terraform destroy` twice to destroy the dependencies)

## TODOs

- Permanent fix for CacheParameterGroupNotFound issue.
- Turn on AUTH with password
- Turn on multi AZ support for cluster
- Implement backup system (or rearchitect to repopulate redis from other sources)
