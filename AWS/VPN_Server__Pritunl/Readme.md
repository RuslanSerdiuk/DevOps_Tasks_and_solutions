# Deploying and replacing the AWS VPN Service with Pritunl on a separate instance

:bangbang: There are situations when we or our customer need to connect to the instance from different IP addresses. **We cannot open port 22 to the whole world!** 
So we will use a VPN. But amazon's VPN is quite expensive. 

<img src ='Screenshots/Billing_VPN.png'>

:grey_exclamation: And in order to save money there is an alternative solution. 
**This is to deploy a VPN Server on a separate instance.**

## :white_medium_square: _Launch instance and Setup VPN Server "Pritunl"_
- [Official site](https://pritunl.com/vpc)
- [Documentation](https://docs.pritunl.com/docs/installation)

EC2 > Launch Instance:
<img src ='Screenshots/Launch_instance_1.png'>
Use Free tier only)

Create Security Group:
<img src ='Screenshots/SG_1.png'>
<img src ='Screenshots/SG_2.png'>

Connect to instance and run command `yum update`
<img src ='Screenshots/Update.png'>

Next, just run these commands :point_down:
```
sudo tee /etc/yum.repos.d/mongodb-org-4.2.repo << EOF
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF

sudo tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/amazonlinux/2/
gpgcheck=1
enabled=1
EOF


sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A

gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp;

sudo rpm --import key.tmp; rm -f key.tmp

sudo yum -y install pritunl mongodb-org 
sudo systemctl start mongod pritunl 
sudo systemctl enable mongod pritunl
```
<img src ='Screenshots/Setup_VPN_Server_2.png'>
<img src ='Screenshots/Setup_VPN_Server_3.png'>

**Check our Server `sudo systemctl status mongod pritunl`** :mag:
<img src ='Screenshots/Setup_VPN_Server_4.png'>

## :white_medium_square: _Configurating Server_

Go to the Public IP:
<img src ='Screenshots/Configurating_server_1.png'>

Click "Advanced"
<img src ='Screenshots/Configurating_server_2.png'>

Click to unsafe link:
<img src ='Screenshots/Configurating_server_3.png'>

We are now on our server:
<img src ='Screenshots/Configurating_server_4.png'>

Go to the console and run command: `sudo pritunl setup-key` and and **paste the result into the appropriate field** on our server in the browser 
<img src ='Screenshots/Configurating_server_5.png'>
And click "Save"

Next, the server will update
<img src ='Screenshots/Configurating_server_6.png'>

Press "Advanced" again
<img src ='Screenshots/Configurating_server_7.png'>

And again click on the unsafe link
<img src ='Screenshots/Configurating_server_8.png'>

Go to the console and run command: `sudo pritunl default-password` and and **paste the result into the appropriate fields** on our server in the browser 
<img src ='Screenshots/Configurating_server_9.png'>
And click **"Sing in"**

### :arrows_counterclockwise: Change credentials:

Now, enter new User and Password:
<img src ='Screenshots/Configurating_server_10.png'>
After that, click **"Save"**

:warning: **But our server will change the Public IP every time the instance is restarted.
Let's give it a permanent IP Address.**

Go to the AWS:

Elastic IP addresses > **Allocate Elastic IP address** > and click "Allocate"
<img src ='Screenshots/Elastic_IP_1.png'>

Now select your new Elastic IP and click **"Action"** and > **"Associate Elastic IP address"**

Select **your instance** and **Privat IP**
<img src ='Screenshots/Elastic_IP_2.png'>
And click **"Associate"**

Next, open your Elastic IP in your browser and enter User and Password.

Click **"Setting"** and enter the **Elastic IP** in the **public address**:
<img src ='Screenshots/Elastic_IP_3.png'>
Click **"Save"**

 :clap: Great! Now our server will always be on the same IP Address.

1. Go to the **Users** > click **Add Organization** > give name:
<img src ='Screenshots/Configurating_server_11.png'>


2. Next, click **Add user** > give name and pin **(REMEMBER IT)**:
<img src ='Screenshots/Configurating_server_12.png'>


3. Go to the **Servers** > click **Add Server**. Enter the **Name** and **Port UDP (this UDP port must be open in the Security Group in the AWS Account)**:
<img src ='Screenshots/Configurating_server_13_v1.png'>

+ Enable **"Allow Multiple Devices"**
+ Disable **"Inter-client Routing"**



4. Attach an Organization and click **Start Server**!
<img src ='Screenshots/Configurating_server_14.png'>


5. Now, go to the **Users** and click **"Get temporary profile links"** and chose any link for you and download
<img src ='Screenshots/Configurating_server_15.png'>


6. Select zip archive and download:
<img src ='Screenshots/Configurating_server_16.png'>


## :white_medium_square: _Setup and Configurating OpenVPN Client_


1. Download the OpenVPN Client: https://openvpn.net/client-connect-vpn-for-windows/
2. Run OpenVPN Client and click **"Import Profile"**
<img src ='Screenshots/Open_VPN_1.png'>


3. Chose **"FILE"** and **Select your profile that you downloaded**.
<img src ='Screenshots/Open_VPN_2.png'>


4. Enter **name** and **pin**

<img src ='Screenshots/Open_VPN_3.png'> <img src ='Screenshots/Open_VPN_4.png'>


5. Success.

<img src ='Screenshots/Open_VPN_5.png'>

7. Check your IP [here](https://www.ipchicken.com/)

<img src ='Screenshots/Success.png'>

## :white_medium_square: _Correct Security Group on the Main Server_

EC2 > SG > Edit inbound rules:

Add rule > Type: **All traffic** > Source: **Elastic IP your VPN Server**
<img src ='Screenshots/Change_SG_on_the_main_server.png'>
Click **"Save Rules"**

#### The End. Now you can give your client access to the VPN server. And your client can create the necessary number of users to access the main server.

### Congratulation! :thumbsup:


## _Links:_
+ _https://www.linuxteacher.com/how-to-setup-pritunl-vpn-server-on-aws-to-access-private-servers/_
+ _https://www.youtube.com/watch?v=pvxbxccf4xM&t=1s_
+ _https://docs.pritunl.com/docs/aws_
