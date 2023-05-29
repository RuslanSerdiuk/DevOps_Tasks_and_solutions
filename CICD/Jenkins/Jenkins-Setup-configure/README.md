# Jenkins - Setup and Configure :hammer_and_wrench:

### _TASK:_
1. Create Key Pair
2. Create Security Group
3. Launching a Master and Worker nodes for Jenkins
4. Install Jenkins
5. Configure Jenkins
6. Connect ec2-agent (Worker Node) to the Jenkins Server 

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
- **AFTER LAUNCH** Master and Worker nodes - add to the Security Group the IP of the Master Node for the port 22. :bangbang:




### _Launching an Amazon EC2 instances_
Now that you have configured a key pair and security group, you can launch an EC2 instances.

To launch an EC2 instances:
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
7. Repeat and launch second instance (Worker Node) and insert the **user-data** (ec2-agent for Jenkins Server):
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
   Replace **aws configure** to your AWS Account

8. Select **Launch Instance**. <img src ='img/launch_instance.jpg'>
9. In the left-hand navigation bar, choose **Instances** to view the status of your instance. Initially, the status of your instance is pending. After the status changes to running, your instance is ready for use. <img src ='img/launch_nodes.jpg'>
10. When both instances are ready, go to our **Security Group** and open 22 ssh port for master Jenkins! :warning: <img src ='img/ssh_Jenkins_Master.jpg'> 




### _Configuring Jenkins_
Jenkins is now installed and running on your EC2 instance. To configure Jenkins:
1. Connect to http://<your_server_public_DNS>:8080 from your browser. You will be able to access Jenkins through its management interface: <img src ='img/unlock_jenkins.png'>
2. As prompted, enter the password found in /var/lib/jenkins/secrets/initialAdminPassword. Use the following command to display this password:
   - ```
     sudo cat /var/lib/jenkins/secrets/initialAdminPassword
     ```
3. The Jenkins installation script directs you to the **Customize Jenkins page**. Click **Install suggested plugins**.
4. Once the installation is complete, the **Create First Admin User** will open. Enter your information, and then select **Save and Continue**. <img src ='img/create_admin_user.png'>
5. On the left-hand side, select **Manage Jenkins**, and then select **Manage Plugins**. 
6. Select the **Available** tab, and then enter **Amazon EC2 plugin** at the top right. 
7. Select the checkbox next to **Amazon EC2 plugin**, and then select **Install without restart**. <img src ='img/install_ec2_plugin.png'>
8. Once the installation is done, select **Back to Dashboard**. 
9. Select **Configure a cloud** if there are no existing nodes or clouds. <img src ='img/configure_cloud.png'>
10. If you already have other nodes or clouds set up, select **Manage Jenkins**.
11. After navigating to **Manage Jenkins**, select **Configure Nodes and Clouds** from the left hand side of the page. <img src ='img/manage-nodes-and-clouds.png'>
12. From here, select **Configure Clouds**. 

   <img src ='img/manage-jenkins-configure-clouds.png'>
13. Select **Add a new cloud**, and select **Amazon EC2**. A collection of new fields appears. <img src ='img/add-amazon-cloud.png'>
14. Click **Add** under Amazon EC2 Credentials: <img src ='img/configure_cloud_add_ec2_credentials.png'>
15. From the Jenkins Credentials Provider, select AWS Credentials as the **Kind**. <img src ='img/jenkins_credentials_provider_aws_credentials.png'>
16. Scroll down and enter in the IAM User programmatic access keys with permissions to launch EC2 instances and select **Add**. <img src ='img/add_access_secret_access_keys.png'>
17. Scroll down to select your region using the drop-down, and select **Add** for the EC2 Key Pair’s Private Key. <img src ='img/configure_cloud_region_private_key.png'>
18. From the Jenkins Credentials Provider, select SSH Username with private key as the Kind and set the Username to ec2-user. <img src ='img/ssh_username.png'>
19. Scroll down and select **Enter Directly** under Private Key, then select **Add**. <img src ='img/private_key_enter_directly.png'>
20. Open the private key pair you created in the creating a key pair step and paste in the contents from "-----BEGIN RSA PRIVATE KEY-----" to "-----END RSA PRIVATE KEY-----". Select **Add** when completed. <img src ='img/enter_private_key.png'>
21. Scroll down to "Test Connection" and ensure it states "Success". Select **Save** when done. <img src ='img/test_connection.png'>

#### Congratulation! You have just installed Jenkins server and configured Master and Worker Nodes for it!




### _LINKS:_
+ _https://www.jenkins.io/doc/book/getting-started/_
+ _https://www.jenkins.io/doc/book/installing/linux/_






