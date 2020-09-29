# protocol-redis
Terraform for persistent redis KV store for protocol

# Set up this repo

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
