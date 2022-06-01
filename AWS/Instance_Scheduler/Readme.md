# Implementing Instance Scheduler in your account


## _[Deploy AWS Instance Scheduler](https://aws.amazon.com/ru/solutions/implementations/instance-scheduler/)_

### Navigate to the AWS Instance Scheduler.
> Click **Launch solution in the AWS Console.**
<img src ='Screenshots/Scheduler_main_page.png'>

> In the CloudFormation console, enter a name for our CloudFormation stack.
> 
> Add tags:
> 
> **started-by=InstanceScheduler**
> 
> **stopped-by=InstanceScheduler**
<img src ='Screenshots/Tags.png'>

> Check Parameters Stack:
<img src ='Screenshots/Stack_parameters.png'>
> And click **Create Stack**

> Wait until it is time for the stack to finish creating all the resources!
<img src ='Screenshots/Stack_completed.png'>
> Congratulation!
> It's success)

### Edit the DynamoDB Tables

> Navigate to **DynamoDB** > **Tables**.
> 
> Select the **ConfigTable**. 
> 
> Select the **uk-office-hours** item.
> 
> Click Actions > Duplicate.
<img src ='Screenshots/DynamoDB_create_office_hours.png'>

> Change the description to **"Office hours in US"**.
> 
> Change the string to **"us-office-hours"**.
> 
> Change the time zone to **"US/Eastern"**.
<img src ='Screenshots/Config_office_hours.png'>
> Click **Create item** and then refresh the table.


### Add Tag to EC2 Instance

> Navigate to **EC2** > **Instances**.
> 
> Select the **running instance**.
> 
> Add the following tag:
> 
> Key: **Schedule**
> 
> Value: **us-office-hours**
<img src ='Screenshots/Add_instance_tag.png'>
> Click Save.

### Update Amazon EventBridge Events Rule

> Navigate to **Amazon EventBridge** > **Events** > **Rules**.
> 
> Select the **listed rule**.
> 
> Click **Actions** > **Edit**.
<img src ='Screenshots/Change_CloudWatch_rule.png'>

> Then next change the* 0/5 minutes* to 1 minute.
<img src ='Screenshots/Correct_CloudWatch_rule.png'>
> Click Next, Next, Next. 
> Click Update rule.

### Update DynamoDB Config Table

> Navigate to DynamoDB > Tables.
> 
> Click the ConfigTable.
> 
> Update the **begintime** and **endtime**
<img src ='Screenshots/Config_period.png'>
> Click Save.

### Verify EC2 Instance Stopped
> Navigate to **EC2** > **Instances**.
> 
> Verify our EC2 instance has stopped.


# _Links:_
- https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/sample-schedule.html
- https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/sample-schedule.html
- https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/components.html