# IaC - Ansible - MongoDB deployment
> Ansible node - yum

> MongoDB nodes - apt

## _TASK:_
1. Deploy MongoDB : Primary node and Secondary nodes
2. Configure database
3. Create service: mongo-demo and configure
4. Create databases: monitoring, operating, testing
5. Create users : 
   - name: **admin** 
     
     DB: **admin**
   
     roles: **root**,**userAdminAnyDatabase**,**read**, 

   - name: **operating** 

     DB: **operating**

     roles: **dbOwner**
   
   - name: **testing** 

     DB: **testing**

     roles: **dbOwner**

### My solution is implemented using a combination of Terraform and Ansible in AWS. If you only need Ansible, go right [here](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Ansible/Deploy_MongoDB/ansible).

#### I just took the Ansible code and posted it to demonstrate working in AWS using Terraform

## _Instructions for demonstrating this solution:_

Your need:
1. Access Key ID
2. Secret Access Key - **[ You can get these credentials from AWS in the IAM service of your profile ]**
3. Key.pem (your ssh secret key for AWS)

**Just run commands step by step**
1. Run command: `git clone -b Ansible_DeployMongoDB https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions.git`
2. put your **Key.pem** in the `/module/EC2` folder and give the name `Ansible.pem`
3. Run command: `terraform init`
4. Enter the following keys. Run commands: 
     - `export TF_VAR_access_key="Your access key"`
     - `export TF_VAR_secret_key="Your secret key"`
     - `export TF_VAR_region="Your region"`
     

5. Run:`terraform apply`
   - wait 5 minutes
6. Connect **via ssh** to public DNS name of Ansible server **[check Terraform Output!]** with help **Ansible.pem** 
7. `cd ansible/`
8. Check work playbooks:
      - `sudo ansible-playbook playbook_secondary_node.yml -i aws_ec2.yaml`
      - `sudo ansible-playbook playbook_primary_node.yml -i aws_ec2.yaml`
   
9. Connect **via ssh** to public dns of MongoDB Primary and Secondary nodes and run:
```
# Primary_Node:
mongo
use <your_db_name> | use operating
db.testcollection.insert({"Name" : "Ruslan"})

# Secondary_Node:
mongo
use <your_db_name> | use operating
show collections
db.testcollection.find()

# Login through users:
mongo -u testing --authenticationDatabase testing -p 13531
```


## _[Dynamic Inventory file:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Ansible/Deploy_MongoDB/ansible/aws_ec2.yaml)_
```
plugin: aws_ec2
regions:
  - us-east-2
filters:
  tag:Name:
  - Primary_Node
  - Secondary_Node
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

## _[Ansible.cnf:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Ansible/Deploy_MongoDB/ansible/ansible.cfg)_
```
[defaults]
host_key_checking  = false
inventory          = ./hosts.txt
interpreter_python = auto_silent
```

## _[Playbook_primary_node](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Ansible/Deploy_MongoDB/ansible/roles/deploy_mongo_primary_node)_
```
- name: Import the public key used by the package management system
  ansible.builtin.apt_key:
    url: https://www.mongodb.org/static/pgp/server-5.0.asc
    state: present

- name: Add specified repository into sources list
  ansible.builtin.apt_repository:
    repo: 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse'
    state: present

- name: install mongodb
  ansible.builtin.apt:
    pkg: mongodb-org
    state: latest
    update_cache: yes

- name: Stop Service mongod
  ansible.builtin.service:
    name: mongod
    state: stopped

- name: copy config file
  template:
    src: mongo_cnf.j2
    dest: "{{ item }}"
    mode: 0644
  loop:
      - /etc/mongo-demo.conf
      - /etc/mongodb-demo.conf

- name: Create mongo-demo service
  template:
    src: mongo-demo.service.j2
    dest: /usr/lib/systemd/system/mongo-demo.service
    mode: 0644

- name: Just force systemd to reread configs
  ansible.builtin.systemd:
    daemon_reload: yes

- name: Start service mongo-demo
  ansible.builtin.service:
    name: mongo-demo
    state: started

- name: Install Python Tools
  apt:
    name:
      - python3
      - python3-pip
      - gcc
    update_cache: yes
    state: latest

- name: Install pymongo
  pip: name=pymongo state=latest

- name: Create a replicaset rs0
  community.mongodb.mongodb_replicaset:
    login_host: "{{ private_ip_primary_node }}"
    login_port: 27017
    login_user: admin
    login_password: "{{ admin_password }}"
    login_database: admin
    replica_set: rs0
    members:
      - host: "{{ public_dns_primary_node }}:27017"
      - host: "{{ public_dns_secondary_node }}:27017"
    validate: no

- name: Wait for the replicaset to stabilise after member addition
  community.mongodb.mongodb_status:
    replica_set: "rs0"
    validate: minimal
    poll: 5
    interval: 30

- name: Create AdminUser and password
  community.mongodb.mongodb_user:
    connection_options:
      - "readPreference=primary"
    database: admin
    name: admin
    password: "{{ admin_password }}"
    roles: "{{ item }}"
    state: present
  loop:
    - userAdminAnyDatabase
    - root
    - read

- name: Create Operating/Testing - Databases/Users
  community.mongodb.mongodb_user:
    login_host: "{{ private_ip_primary_node }}"
    login_port: 27017
    login_user: admin
    login_password: "{{ admin_password }}"
    database: "{{ item.db }}"
    name: "{{ item.name }}"
    password: "{{ item.pw }}"
    roles: "dbOwner"
    state: present
  loop:
    - { db: 'operating', name: 'operating', pw: "{{ operating_pw }}" }
    - { db: 'testing', name: 'testing', pw: "{{ testing_pw }}" }


- name: Create TEST db and User
  community.mongodb.mongodb_user:
    login_host: "{{ private_ip_primary_node }}"
    login_port: 27017
    login_user: admin
    login_password: "{{ admin_password }}"
    database: "Test"
    name: "Ruslan"
    password: "{{ test_password }}"
    roles: "dbOwner"
```

## _[Playbook_secondary_node](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/Ansible/Deploy_MongoDB/ansible/roles/deploy_mongo_secondary_node)_
```
- name: Import the public key used by the package management system
  ansible.builtin.apt_key:
    url: https://www.mongodb.org/static/pgp/server-5.0.asc
    state: present

- name: Add specified repository into sources list
  ansible.builtin.apt_repository:
    repo: 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse'
    state: present

- name: install mongodb
  ansible.builtin.apt:
    pkg: mongodb-org
    state: latest
    update_cache: yes

- name: Stop Service mongod
  ansible.builtin.service:
    name: mongod
    state: stopped

- name: copy config file
  template:
    src: mongo_cnf.j2
    dest: "{{ item }}"
    mode: 0644
  loop:
      - /etc/mongo-demo.conf
      - /etc/mongodb-demo.conf

- name: Create mongo-demo service
  template:
    src: mongo-demo.service.j2
    dest: /usr/lib/systemd/system/mongo-demo.service
    mode: 0644

- name: Just force systemd to reread configs
  ansible.builtin.systemd:
    daemon_reload: yes

- name: Start service mongo-demo 
  ansible.builtin.service:
    name: mongo-demo
    state: started

- name: Install Python Tools
  apt:
    name:
      - python3
      - python3-pip
      - gcc
    update_cache: yes
    state: latest

- name: Install pymongo
  pip: name=pymongo state=latest
```

### _Ansible official documentation was used for this assignment:_
+ _https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu+ https://docs.ansible.com/ansible/2.9/plugins/inventory/aws_ec2.html_
+ _https://docs.ansible.com/ansible/latest/collections/community/mongodb/index.html#description_
+ _https://docs.ansible.com/ansible/latest/collections/community/mongodb/mongodb_parameter_module.html#parameter-connection_options_
+ _https://docs.ansible.com/ansible/latest/collections/community/mongodb/mongodb_replicaset_module.html#ansible-collections-community-mongodb-mongodb-replicaset-module_
+ _https://docs.ansible.com/ansible/latest/collections/community/mongodb/mongodb_user_module.html#ansible-collections-community-mongodb-mongodb-user-module_
+ _https://docs.ansible.com/ansible/latest/collections/community/mongodb/mongodb_status_module.html_

### _MongoDB official documentation was used for this assignment:_
+ _https://www.mongodb.com/docs/manual/core/replica-set-architecture-three-members/_
+ _https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/_
+ _https://www.mongodb.com/docs/manual/tutorial/deploy-replica-set/_
+ _https://www.mongodb.com/docs/manual/tutorial/expand-replica-set/_
+ _https://www.mongodb.com/docs/manual/tutorial/list-users/_
+ _https://www.mongodb.com/docs/manual/reference/built-in-roles/_

### _Also you can check all [ansible config]()_