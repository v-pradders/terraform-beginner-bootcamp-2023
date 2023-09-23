# Terraform Beginner Bootcamp 2023
## Install terraform

### Why Terraform Installation is required?
terraform installation steps are outdated in the gitpod yml, this needs updating

### checked os version
used this command to identify the os version

```
cat /etc/os-release

```
output of the above command showed its ubuntu version

### terraform install commands

After identifying the os version, [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) this page has details about the installation
select the Install terraform, Linux option to get the list of required commands

### Install commands as bash script

refactored terraform install steps as bash script
script is here [./bin/install_terraform_cli](./bin/install_terraform_cli)

###  shebang to be used at the start of the script
per chat gpt  `#!/usr/bin/env bash`
this tells the bash script of the program that will interpret it

### updated the permissions of the script
permissions of the script needs to be updated for execution

`chmod 777 ./bin/install_terraform_cli`

### ran the script

used this command to run the script and install terraform

`./bin/install_terraform_cli`

or use `source ../bin/install_terraform_cli` and no permission update required. 

### updated the gitpod yml file to use this new script for installation as the existing commands are outdated

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
## added main.tf with provider information
## added main.tf with random and s3 bucket creation resources
## tried terraform init, plan, apply and destroy commands first time
## created new generate tfrc credentials bash file
## set gp env with correct token obtained from this link [login] (https://app.terraform.io/app/settings/tokens?source=terraform-login)
## ran terraform , init, plan , apply - saw the resources are appearing in terraform cloud
