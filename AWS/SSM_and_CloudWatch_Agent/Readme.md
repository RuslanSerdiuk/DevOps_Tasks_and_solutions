# Implement SSM + CloudWatch Agent to your instance

#### SSM is needed in case you lose access to your instance. For example, you lost your ssh key.
#### CloudWatch Agent is needed to get metrics from your volum. such as free space

## _Part 1 - [Create role]_

First of all we need create Role for our agents. 

> Click **IAM** > **Roles** > **Create Role** and Select **EC2**
> <img src ='Screenshots/Create_role.png'>

> Next add **AmazonSSMManagedInstanceCore**
> <img src ='Screenshots/SSM_role.png'>

> and add **CloudWatchAgentAdminPolicy** and **CloudWatchAgentServerPolicy**
> <img src ='Screenshots/CloudWatch_Agent_role.png'>

> So, give name **"SSM_CloudWatch_role"** for your role:
> <img src ='Screenshots/Add_name_role.png'>

> And check all permitions:
> <img src ='Screenshots/All_permition_role.png'>
> Now just click **Create role**

> Next attach your role to your instance:
> 
> Select your instance
> 
> right-click on it
> 
> Select **Security**
> 
> and Select **Modify IAM Role**
> <img src ='Screenshots/Modify_role.png'>

> Now just select your role from list:
> <img src ='Screenshots/Modify_role_2.png'>

> Congratulations! Your role has been attached.
> <img src ='Screenshots/Modify_role_successfully.png'>

## _PART 2 - [Install SSM Agent to your instance]_

> WARNING! 
> 
> **If you don't have access to your instance, the ssm agent can only be implemented by creating a new instance!**
> 
> You should already have access to your instance. For example ssh.

> In most cases, SSM Agent is preinstalled on AMIs provided by AWS for the following operating systems (OSs):
> 
> - Amazon Linux Base AMIs dated 2017.09 and later 
>
> - Amazon Linux 2 
> 
> - Amazon Linux 2 ECS-Optimized Base AMIs 
> 
> - macOS 10.14.x (Mojave), 10.15.x (Catalina), and 11.x (Big Sur)
> 
> - SUSE Linux Enterprise Server (SLES) 12 and 15 
> 
> - Ubuntu Server 16.04, 18.04, and 20.04 
> 
> - Windows Server 2008-2012 R2 AMIs published in November 2016 or later 
> 
> - Windows Server 2016, 2019, and 2022

> I using [AWS documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html) and choosing my  version OS.
> <img src ='Screenshots/Install_SSM_1.png'>

> I Have Ubuntu Server 20.10 STR 64-bit (Snap package installation).
> 
> So, I just Run the following command to determine if SSM Agent is running: `sudo systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service`
> <img src ='Screenshots/Install_SSM_3.png'>
>  
> and a few other commands:
> 
> <img src ='Screenshots/Install_SSM_2.png'>

#### So, SSM Agent is installed and running. Ok, run the SSM Session.

> Select **AWS Systems Manager** > **Session Manager**
> <img src ='Screenshots/Start_SSM_Session.png'>
> Select your instance and click **Start session**

> Congratulations!
> <img src ='Screenshots/SSM_user.png'>

## PART 3 - [Install CloudWatch Agent to your instance]

> I using [AWS documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/download-cloudwatch-agent-commandline.html) too.
> Select your version OS and copy link for download:
> <img src ='Screenshots/Install_CloudWatch_Agent_1.png'>

> Run the command: `wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb`
> <img src ='Screenshots/Install_CloudWatch_Agent_2.png'>

> If you downloaded a DEB package on a Linux server, change to the directory containing the package and enter the following: `sudo dpkg -i -E ./amazon-cloudwatch-agent.deb`
> <img src ='Screenshots/Install_CloudWatch_Agent_3.png'>

#### Ok, now create the [CloudWatch agent configuration file](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-cloudwatch-agent-configuration-file-wizard.html) with the wizard!

> Start the CloudWatch agent configuration wizard by entering the following: `sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard`
> <img src ='Screenshots/CloudWatch_config_file.png'>
> <img src ='Screenshots/CloudWatch_config_file_2.png'>
> <img src ='Screenshots/CloudWatch_config_file_3.png'>
> <img src ='Screenshots/CloudWatch_config_file_4.png'>

#### So, we got the json configuration file:
```
{
        "agent": {
                "metrics_collection_interval": 60,
                "run_as_user": "root"
        },
        "metrics": {
                "aggregation_dimensions": [
                        [
                                "InstanceId"
                        ]
                ],
                "append_dimensions": {
                        "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                        "ImageId": "${aws:ImageId}",
                        "InstanceId": "${aws:InstanceId}",
                        "InstanceType": "${aws:InstanceType}"
                },
                "metrics_collected": {
                        "cpu": {
                                "measurement": [
                                        "cpu_usage_idle",
                                        "cpu_usage_iowait",
                                        "cpu_usage_user",
                                        "cpu_usage_system"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ],
                                "totalcpu": false
                        },
                        "disk": {
                                "measurement": [
                                        "used_percent",
                                        "inodes_free"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "diskio": {
                                "measurement": [
                                        "io_time"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "mem": {
                                "measurement": [
                                        "mem_used_percent"
                                ],
                                "metrics_collection_interval": 60
                        },
                        "statsd": {
                                "metrics_aggregation_interval": 60,
                                "metrics_collection_interval": 10,
                                "service_address": ":8125"
                        },
                        "swap": {
                                "measurement": [
                                        "swap_used_percent"
                                ],
                                "metrics_collection_interval": 60
                        }
                }
        }
```

> Let's to store the config in the SSM parameter store:
> <img src ='Screenshots/CloudWatch_config_file_done.png'>

> And check our file in Parameter Store:
> <img src ='Screenshots/Check_Parameter_Store.png'>


Let's replace the configuration file with our custom configuration file: `sudo vim /opt/aws/amazon-cloudwatch-agent/bin/config.json`
```
{
        "agent": {
                "metrics_collection_interval": 60,
                "run_as_user": "root"
        },
        "metrics": {
                "aggregation_dimensions": [
                        [
                                "InstanceId"
                        ]
                ],
                "append_dimensions": {
                        "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                        "ImageId": "${aws:ImageId}",
                        "InstanceId": "${aws:InstanceId}",
                        "InstanceType": "${aws:InstanceType}"
                },
                "metrics_collected": {
                        "collectd": {
                                "metrics_aggregation_interval": 60
                        },
                        "cpu": {
                                "measurement": [
                                        "cpu_usage_idle",
                                        "cpu_usage_iowait",
                                        "cpu_usage_user",
                                        "cpu_usage_system"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ],
                                "totalcpu": false
                        },
                        "disk": {
                                "measurement": [
                                        "used_percent"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "diskio": {
                                "measurement": [
                                        "io_time"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "mem": {
                                "measurement": [
                                        "mem_used_percent",
                                        "available_percent",
                                        "total",
                                        "used",
                                        "free",
                                        "available"
                                ],
                                "metrics_collection_interval": 60
                        },
                        "statsd": {
                                "metrics_aggregation_interval": 60,
                                "metrics_collection_interval": 10,
                                "service_address": ":8125"
                        },
                        "swap": {
                                "measurement": [
                                        "swap_used_percent"
                                ],
                                "metrics_collection_interval": 60
                        }
                }
        }
}
```

> And in Parameter Store, just click **Edit**
> <img src ='Screenshots/Cusctom_config_file.png'>

> And paste your custom configuration code here:
> <img src ='Screenshots/Cusctom_config_file_2.png'>
> And click **Save changes**


> Next you need Select **AWS Systems Manager** > **Run Command** > and click **Run Command**
> 
> Search **AmazonCloudWatch-ManageAgent**
> <img src ='Screenshots/Run_Command_1.png'>

#### Command parameters:
> Action: **configure**
> 
> Optional Configuration Location: **AmazonCloudWatch-linux** from Parameter Store
> <img src ='Screenshots/Run_Command_2.png'>
> <img src ='Screenshots/Run_Command_3.png'>

> Targets:
> <img src ='Screenshots/Run_Command_4.png'>

> And click **Run**
> <img src ='Screenshots/Run_Command_5.png'>

> Failed. Hmm...
> 
> Let's check the output:
> <img src ='Screenshots/Run_Command_6.png'>

> **Just install CollectD: `sudo apt install collectd`:**
> 
> <img src ='Screenshots/Run_Command_7.png'>
> 
> **Or choose "no" at this point:**
> 
> <img src ='Screenshots/CloudWatch_config_file_3 - Copy.png'>

> Now click **Return**
> <img src ='Screenshots/Run_Command_8.png'>


> **YES!**
> <img src ='Screenshots/Run_Command_9.png'>

## _PART 4 - [Config Cloud Watch Dashboard]_

> Go to the Cloud Watch and create my own dashboard and add widget:
> <img src ='Screenshots/Check_metrics_0.5.png'>
> <img src ='Screenshots/Check_metrics_0.7.png'>
> <img src ='Screenshots/Check_metrics_1.png'>
> <img src ='Screenshots/Check_metrics_2.png'>
> 
> **Adding used disk space**
> <img src ='Screenshots/Check_metrics_3.png'>
> <img src ='Screenshots/Check_metrics_4.png'>
> 
> And some more metrics
> <img src ='Screenshots/Check_metrics_5.png'>
> and click **Save dashboard**

## _Useful links:_
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-EC2-Instance.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/download-cloudwatch-agent-commandline.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-cloudwatch-agent-configuration-file-wizard.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html