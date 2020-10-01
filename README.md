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

## Delete the Redis KV store

To tear down the redis:
```
terraform destroy
```

(You may have to run `terraform destroy` twice to destroy the dependencies)
