# IaC - Ansible

## _TASK:_
- Create your own inventory file, in which host groups: **app**, **db**
- For all groups - **ssh key access**. Configuration of general ssh parameters and Inventory location - put it in `ansible.cfg`
- Create a playbooks that do the following:
  - Install apache and php on APP hosts
  - Install mysql on DB host
  - Creates a user and a database
  - Deploys the project code https://github.com/FaztWeb/php-mysql-crud
- Use jinja-templates for configure apache and mysql connection

### My solution is implemented using a combination of Terraform and Ansible in AWS. If you only need Ansible, go right [here]().

#### I just took the Ansible code and posted it to demonstrate working in AWS using Terraform

## _Instructions for demonstrating this solution:_

Your need:
1. Access Key ID
2. Secret Access Key - **[ You can get these credentials from AWS in the IAM service of your profile ]**
3. Key.pem (your ssh secret key for AWS)

**Just run commands step by step**
1. Run command: `git clone https://`
2. put **Key.pem** in the `/module/EC2` folder and give the name `Ruslan-key-Ohio-TASK22.pem`
3. Run command: `terraform init`
4. Enter the following keys. Run commands: 
     - `export TF_VAR_access_key="Your access key"`
     - `export TF_VAR_secret_key="Your secret key"`
     - `export TF_VAR_region="Your region"`
     

5. Run:`terraform apply`
   - wait 5 minutes
   - check public DNS name of App server


## _[Dynamic Inventory file:](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m9-Ansible-Task-01/Module-09_Ansible/Task-01/ansible/aws_ec2.yaml)_
```
plugin: aws_ec2
regions:
  - us-east-2
filters:
  tag:Name:
  - Ansible_app
  - Ansible_db
keyed_groups:
  # Add e.g. x86_64 hosts to an arch_x86_64 group
  - prefix: arch
    key: 'architecture'
  # Add hosts to tag_Name_Value groups for each Name/Value tag pair
  - prefix: tag
    key: tags
  # Add hosts to e.g. instance_type_z3_tiny
  - prefix: instance_type
    key: instance_type
```

## _[Ansible.cnf:](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m9-Ansible-Task-01/Module-09_Ansible/Task-01/ansible/ansible.cfg)_
```
[defaults]
host_key_checking  = false
inventory          = ./hosts.txt
interpreter_python = auto_silent
```

## _[Playbook_app](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m9-Ansible-Task-01/Module-09_Ansible/Task-01/ansible/roles/deploy_app)_
```
---
- name: Install Apache
  hosts: tag_Name_Ansible_app
  become: yes

  roles:
    - deploy_app
```

## _[Playbook_db](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m9-Ansible-Task-01/Module-09_Ansible/Task-01/ansible/roles/deploy_db)_
```
---
- name: Install MySql
  hosts: tag_Name_Ansible_db
  become: yes

  roles:
    - deploy_db
```

### _Official documentation was used for this assignment:_
+ _https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu+ https://docs.ansible.com/ansible/2.9/plugins/inventory/aws_ec2.html_
+ _https://docs.ansible.com/ansible/2.9/modules/command_module.html_
+ _https://docs.ansible.com/ansible/2.5/modules/shell_module.html#shell-module_

### _Also I used unofficial sources:_
+ _https://phpraxis.wordpress.com/2016/09/27/enable-sudo-without-password-in-ubuntudebian/_
+ _https://www.youtube.com/watch?v=5VjcJNQ7nlI&list=PLg5SS_4L6LYufspdPupdynbMQTBnZd31N&index=13_
+ _https://www.youtube.com/watch?v=RmzMcIapwPE&list=PLg5SS_4L6LYufspdPupdynbMQTBnZd31N&index=27_
+ _https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu_
+ _https://techviewleo.com/install-php-8-on-amazon-linux/_
+ _https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-centos-7_
+
+ _https://stackoverflow.com/questions/70144079/ansible-set-mysql-8-initial-root-password-on-rhel-7_
+ _https://www.continuent.com/resources/blog/automated-mysql-server-preparation-using-ansible_
+ _https://stackoverflow.com/questions/1559955/host-xxx-xx-xxx-xxx-is-not-allowed-to-connect-to-this-mysql-server_
+ _https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded_

### _Also you can check all [ansible config]()_