# Terraform Beginner Bootcamp 2023
## Install terraform

### Why Terraform Installation is required?
terraform installation steps are outdated in the gitpod yml, this needs updating

### OS version
used this command to identify the os version

```
cat /etc/os-release

```
output of the above command showed its ubuntu version

### Terraform install commands

After identifying the os version, [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) this page has details about the installation
select the Install terraform, Linux option to get the list of required commands

### Install commands as bash script

refactored terraform install steps as bash script
script is here [./bin/install_terraform_cli](./bin/install_terraform_cli)

###  Shebang to be used at the start of the script
per chat gpt  `#!/usr/bin/env bash`
this tells the bash script of the program that will interpret it

### Update permissions of the script
permissions of the script needs to be updated for execution

`chmod 777 ./bin/install_terraform_cli`

### Run the Bash script

used this command to run the script and install terraform

`./bin/install_terraform_cli`

or use `source ../bin/install_terraform_cli` and no permission update required. 

### Update gitpod yml to use the bash script

init will not rerun if existing workspace restarted, before will be used

also gitpod yml will be updated to use the newly created bash script

## Install AWS CLI

### Refactor AWS CLI
AWS installation steps are working fine already in the gitpod yml file, just that installation steps should be refactored as bash

### installation steps
- similar to terraform cli installation refactoring
- added shebang
- additional added commands to remove installation download files and folders using rm & rm -rf commands
- remaining install commands copied from gitpod yml file to install_aws_cli bash

### AWS user details
We can identify if AWS credentials are configured correctly by running below:
```sh
aws sts get-caller-identity
```

# New updates 
- I have managed to install terraform and aws cli
- Also updated aws credentials in the required environment variables
- if i login to a gitpod session, aws cli bash terminal will display my identity through sts get-caller-identity coomand in the bash script
- if i go to the terraform terminal, and run terraform -help it will display the help information
- now the plan is to create resources in aws through terraform and update the state file to terraform cloud
- terraform cloud account needs to be created as a pre-requisite [terraform cloud] (https://app.terraform.io/app/organizations)

## Added main.tf with provider information
- first added the provider information in the main.tf file
- added details related to random and aws providers
- copied the provider details from [terraform provider] (https://registry.terraform.io/browse/providers)

## Added main.tf with random and s3 bucket creation resources

- after adding the providers, now added resource for creating random string [random string resource] (https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)
- added s3 bucket creation resource using this link [s3bucket] (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- added output variable to display the random string which is also the bucket name

## Terraform init, plan, apply and destroy commands
- after adding the required code in main.tf, ran terraform init
- this downloaded the providers information under .terraform folder
- ran terraform plan which actually showed whats going to get created, it displayed s3 bucket will get created
- ran terraform apply and created the required resources in aws , went to the console and saw the s3 bucket created
- ran terraform destroy and removed the resources

## Terraform cloud configuration
- created new bash tfrc credentials file
- this will read the env variable terraform cloud token and update the file [/home/gitpod/.terraform.d/credentials.tfrc.json](/home/gitpod/.terraform.d/credentials.tfrc.json)
- set gp env with correct token obtained from this link [login] (https://app.terraform.io/app/settings/tokens?source=terraform-login)
- ran into issues for some time because of token generated from the incorrect page

## Resources in terraform cloud

- ran terraform , init, plan , apply - saw the resources are appearing in terraform cloud
- also resource is appearing in the aws console




