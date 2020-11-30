# protocol-redis
Terraform for persistent redis KV store for protocol

## Set up the Redis KV store on an AWS account

Install tfenv:
```
brew install tfenv
```

Install Terraform at 0.12 (the current versions of cloudposse templates don't work with terraform 13 yet):
```
tfenv install 0.12.29
tfenv use 0.12.29
```

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

### Note

Currently this results in an error

```
Error: expected length of replication_group_id to be in the range (1 - 40)
```


## Delete the Redis KV store

To tear down the redis:
```
terraform destroy
```

(You may have to run `terraform destroy` twice to destroy the dependencies)

## TODOs

- Fix Error: expected length of replication_group_id to be in the range (1 - 40)
- Implement backup system (or rearchitect to repopulate redis from other sources)
- Figure out how to connect to the cluster from within the VPC
