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
