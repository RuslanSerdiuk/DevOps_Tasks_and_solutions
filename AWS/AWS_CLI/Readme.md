# :infinity: Creating and configuring a user for access via the AWS CLI :infinity:

:bangbang: There are situations when an infrastructure orderer in AWS needs to **start/stop a server independently after hours or on a weekend**. For such situations, it was decided to create a separate user and assign it a **restricted policy for security purposes**.

Suppose we have an infrastructure consisting of several servers. And we only want our client to be able to start and stop its server in AWS.

## _Create user in IAM:_

:white_medium_square: Go to the Identity Access Management > Users > Create User:
<img src ='Screenshots/Create_user_1.png'>

:white_medium_square: Enter the **name** and Enable only **Programmatic access**:
<img src ='Screenshots/Create_user_2.png'>
And click **Next:Permissions**

:white_medium_square: Now Select **Attach existing policies directly** and click **Create Policy**:
<img src ='Screenshots/Create_user_3.png'>

:white_medium_square: Select JSON and paste this policy:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/Admin": "Oleksii"
                }
            }
        }
    ]
}
```
:exclamation: This policy will give our client only the right to start and stop the server by the tag **Key - Admin**, **value - Oleksii**. Which will be quite safe, because the client will not have access to the rest of the resources of our infrastructure.

<img src ='Screenshots/Create_user_4.png'>

Click **Next:Tags** and **Next:Review**

Enter name: **CustomUserPolicy** and **discription** and click **Create Policy**:

:white_medium_square: Back to adding permissions to user, update the search and find our policy:
<img src ='Screenshots/Create_user_5.png'>
Click **Next:Tags**, **Next:Review** and **Create User**

:white_medium_square: Now check our credentials. Click **show**:
<img src ='Screenshots/Create_user_6.png'>

:warning: Save **Access Key ID** and **Secret Access Key**

<img src ='Screenshots/Create_user_7.png'>

And click **Close**

#### Send Credentials to your client in a private secure message.

:white_medium_square: Go to EC2 > Select your instance > Tags > Manage Tags > Add tag:

+ Key: **Admin**, value: **Oleksii**
<img src ='Screenshots/Add_Tags.png'>

Click **Save**

## _Your client needs:_

#### Download and Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

#### Run `aws configure` and Configuring AWS CLI:
```
AWS Access Key ID [None]: AKIAVTA5WYZ2BXS2UN7R
AWS Secret Access Key [None]: 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
Default region name [None]: eu-central-1
Default output format [None]: json
```

<img src ='Screenshots/Create_user_8.png'>

And use these commands for start/stop:
+ Start instance: `aws ec2 start-instances --instance-ids i-0c0bddef92ebf0674`
+ Stop instance: `aws ec2 stop-instances --instance-ids i-0c0bddef92ebf0674`


## _Links:_
+ _https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instance-status.html_
+ _https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_ec2-start-stop-tags.html_
+ _https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html_
