# AWX_Terraform

![Ansible](/images/awx.png)

___

 ### What is AWX?

Ansible Tower (formerly ‘AWX’) is a web-based solution that makes Ansible even more easy to use for IT teams of all kinds. It’s designed to be the hub for all of your automation tasks.

___

 ### Prerequisites
 For this guide, you will need:

- an AWS account with the proper IAM permissions 

### System Requirements

- At least 4GB of memory
- At least 2 cpu cores
- At least 20GB of space



### Set up and initialize your Terraform workspace
In your terminal, clone the following repository. Once you have cloned the repository, create terraform.tfvars file according to variables.tf file and then initialize your Terraform workspace, which will download and configure the providers.
In your initialized directory, run terraform apply and review the planned actions. Your terminal output should indicate the plan is running and what resources will be created.
Copy public_ip address and paste in browser

### ATTANTION

IF AWX stuck in AWX Upgrading phase
please ssh to machine and stop, restart docker service. In my case I did that even few times...

```
sudo systemctl stop docker
```
```
sudo systemctl start docker
```
```
sudo systemctl restart docker
```
