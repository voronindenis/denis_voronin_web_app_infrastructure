# Denis Voronin's web application infrastructure

This repository contains Terraform code to create a web application infrastructure in Selectel and 
Ansible configuraion for deploy a web application.

## Terraform directory

The Terraform directory contains the module for creating a project with a user and server with remote root disk.
The module uses the following submodules:
- flavor
- floatingip
- image_datasource
- keypair
- nat
- project
- project_with_user
- server_remote_root_disk

You can find more Selectel Terraform modules in the [Selectel Terraform repository](https://github.com/selectel/terraform-examples).


### Example usage

```sh
cd terraform

terraform init

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply -target=module.project_with_user

env \
  TF_VAR_username=USER \
  TF_VAR_password=PASSWORD \
  TF_VAR_domain_name=ACCOUNT_ID \
  TF_VAR_user_password=xxx \
  terraform apply
```

- USER variable is your service user in Selectel username ([read more](https://docs.selectel.ru/en/terraform/quickstart/#add-service-user)).
- PASSWORD variable is your service user in Selectel password ([read more](https://docs.selectel.ru/en/terraform/quickstart/#add-service-user)).
- ACCOUNT_ID variable is Selectel account number. You can look in [control panels](https://my.selectel.ru/?pk_vid=1e03812f18ed824a173518942178dbb8) in the upper right-hand corner.
- xxx is a new password for the service user you are creating.

## Ansible directory

This directory contains the ansible configuration for deploy the Frontend Next.js application on the Selectel server.
It includes the following play's:
- frontend

### Roles

#### frontend

This role installs the Frontend Next.js application on the server. It uses the following tasks:
- Install Node.js
- Install Git
- Install Nginx
- Clone the repository
- Install dependencies
- Build the application
- Start the application with Nginx

#### Example usage

Open the `run.sh` file and replace the `host` variable with the IP address of the server you want to deploy the application to.
Then run the following command:

```sh
sh run.sh
```
