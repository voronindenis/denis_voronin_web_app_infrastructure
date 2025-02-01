# Ansible configuration for Frontend Next.js application

This directory contains the ansible configuration for deploy the Frontend Next.js application on the Selectel server.
It includes the following play's:
- frontend

## Roles

### frontend

This role installs the Frontend Next.js application on the server. It uses the following tasks:
- Install Node.js
- Install Git
- Install Nginx
- Clone the repository
- Install dependencies
- Build the application
- Start the application with Nginx

### Example usage

Open the `run.sh` file and replace the `host` variable with the IP address of the server you want to deploy the application to. 
Then run the following command:

```sh
sh run.sh
```
