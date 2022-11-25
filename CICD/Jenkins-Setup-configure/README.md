# Jenkins [Setup and Configure]

### _TASK:_
1. requirement: add versioning for images
2. create image (create script for run lambdas simple)
3. push to ecr
4. notifications

#### _Prerequisites:_
1. An AWS account. If you don’t have one, you can register [here](https://portal.aws.amazon.com/billing/signup#/start).
2. An Amazon EC2 key pair. If you don’t have one, refer to [Creating a key pair](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#creating-a-key-pair).
3. An AWS IAM User with programmatic key access and [permissions to launch EC2 instances](https://plugins.jenkins.io/ec2/#plugin-content-iam-setup)




### _Creating a key pair_
Creating a key pair helps ensure that the correct form of authentication is used when you install Jenkins.

To create your key pair:
1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/ and sign in.
2. In the navigation pane, under **NETWORK & SECURITY**, select **Key Pairs**.
3. Select **Create key pair**.
4. For **Name**, enter a descriptive name for the key pair. Amazon EC2 associates the public key with the name that you specify as the **key name**. A key name can include up to 255 ASCII characters. It cannot include leading or trailing spaces.
5. For **File format**, select the format in which to save the private key.
   - For OpenSSH compatibility, select **pem**. 
   - For PuTTY compatibility, select **ppk**.
6. Select **Create key pair**.
7. The private key file downloads automatically. The base file name is the name you specified as the name of your key pair, and the file name extension is determined by the file format you chose. Save the private key file in a safe place.




### _Creating a security group_
A security group acts as a firewall that controls the traffic allowed to reach one or more EC2 instances. When you launch an instance, you can assign it one or more security groups. You add rules that control the traffic allowed to reach the instances in each security group. You can modify a security group’s rules any time, and the new rules take effect immediately.

For this task, you will create a security group and add the following rules:
- Allow inbound HTTP access from anywhere. 
- Allow inbound SSH traffic from your computer’s public IP address so you can connect to your instance.
- **AFTER LAUNCH** Master and Worker nodes - add to the Security Group the IP of the Master Node for the port 22.




### _Launching an Amazon EC2 instances_
Now that you have configured a key pair and security group, you can launch an EC2 instance.

To launch an EC2 instance:
1. Sign in to the the [AWS Management Console](https://console.aws.amazon.com/ec2/). 
2. Open the Amazon EC2 console by selecting EC2 under **Compute**. 
3. From the Amazon EC2 dashboard, select **Launch Instance**.
4. The **Choose an Amazon Machine Image (AMI)** page displays a list of basic configurations called Amazon Machine Images (AMIs) that serve as templates for your instance. Select the HVM edition of the **Amazon Linux AMI**. <img src ='img/choose-AMI.jpg'>
5. Scroll down and select the key pair you created in the creating a key pair section above or any existing key pair you intend to use.
   - Select **Select an existing security group**. 
   - Select the security group that you created.
6. Now go to the bottom of the page and use **Advanced details** to insert the **user-data** for the Master Node (main Jenkins Server):
    ```
    #!/bin/bash
    
    sudo su
    yum update -y
    
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
        https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum upgrade
    
    sudo amazon-linux-extras install java-openjdk11 -y
    
    sudo yum install jenkins -y
    sudo systemctl daemon-reload
    
    sudo systemctl enable jenkins
    sudo systemctl start jenkins   
    ```
7. Repeat and launch second instance (Worker Nodes) and insert the **user-data** (ec2-agent for Jenkins Server):
    ```
    #!/bin/bash
    
    sudo su
    yum update -y
    
    # docker
    sudo yum install docker
    sudo usermod -a -G docker ec2-user
    newgrp docker
    
    # docker-compose
    wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
    sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
    sudo chmod -v +x /usr/local/bin/docker-compose
    
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    
    sudo ./aws/install
    aws configure
    <enter your Access Key>
    <enter your Secret Access Key>
    <enter your region>
    ```
8. Select **Launch Instance**. <img src ='img/launch_instance.jpg'>
9. In the left-hand navigation bar, choose **Instances** to view the status of your instance. Initially, the status of your instance is pending. After the status changes to running, your instance is ready for use. <img src ='img/launch_nodes.jpg'>






















