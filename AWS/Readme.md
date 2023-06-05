# Opportunities for migration and cost optimization in AWS

### In this mini-article, I will talk about a few effective tips that helped me reduce the cost on the project:
1. EC2: Use latest instances families or migrate to the latest AMD (*a) or Graviton (*g) instance families when possible for better price performance ratio. [List of all instance type in AWS](https://aws.amazon.com/ru/ec2/instance-types/).
2. EC2: Review underutilized EC2 instances and downscale when possible. To enable memory metrics delivered to CloudWatch you can install and configure CloudWatch agent on EC2 instances as described in [docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html)
3. EBS: Consider migration of GP2 volumes to GP3. [This blog](https://aws.amazon.com/ru/blogs/storage/migrate-your-amazon-ebs-volumes-from-gp2-to-gp3-and-save-up-to-20-on-costs/) post provides more consideration details for migration.
4. S3: Consider creation of [lifecycle policies to transition data to cheaper storage type](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-transition-general-considerations.html) for buckets with no API calls during previous month. Review usage patter for ntukhpi-bucket and consider reducing amount of ListBucket API calls.
5. RDS: Use latest instances families or migrate to Graviton MySQL and MariaDB instances with compatible versions. Key migration considerations listed in the [blog post](https://aws.amazon.com/ru/blogs/database/key-considerations-in-moving-to-graviton2-for-amazon-rds-and-amazon-aurora-databases/).
6. RDS: review Idle RDS instances. Consider using Aurora Serverless for infrequently-used applications, with peaks of 30 minutes to several hours a few times each day 
7. **General.** Please use following cost optimization tools and services:
   + Continuously review cost and usage of your workloads.
   + [AWS Trusted Advisor](https://aws.amazon.com/ru/premiumsupport/technology/trusted-advisor/)
   + [AWS Compute Optimizer](https://aws.amazon.com/ru/compute-optimizer/)
   + [Instance Scheduler](https://aws.amazon.com/ru/solutions/implementations/instance-scheduler/)

> #### If you have any questions please feel free to email me or contact me on [LinkedIn](https://www.linkedin.com/in/ruslan-serdiuk/)
    

### Below are various solutions that have helped me in my work with optimization in AWS:

[Simple Application](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/Task_1_Simple_Application) - test task to understand how some services work and how they relate to each other

[Instance_Scheduler](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/Instance_Scheduler) - How to easy implement the Instance Scheduler in your account

[SSM and CloudWatch Agents](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/SSM_and_CloudWatch_Agent) - Implementing the SSM and CloudWatch Agents to your instance for get metrics (space of volume, RAM, etc.)

[Migrate MariaDB to RDS Aurora Serverless v1](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/Migrate_MariaDB_to_RDS_Aurora_Serverless_v1) - How to quickly migrate your MariaDB to Aurora and resolve some problem while migration process

[Reduce Volume Size in AWS Instance](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/Reduce_Volume_size) - In this article, I will give a clear step-by-step guide on how to reduce the size of the root volume on an AWS instance without losing data.

[Increase Volume Size](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/Increase_volume_size) - How to correctly and quickly increase the size of the root volume in AWS

[VPN Server "Pritunl" in AWS](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/VPN_Server__Pritunl) - How to reduce the cost of AWS VPN? Simply replace with your own VPN server!

[Creating and configuring a user for AWS CLI for your client](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/AWS_CLI) - How to securely give a client access to a server in your AWS infrastructure

[CodePipeline - Build and Deploy Lambda](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/main/AWS/CodePipeline-CodeDeploy) - Create CodePipeline (manually) / Write **buildspec.yaml** for CodeBuild / Add versioning for images / Push to ecr / Deploying lambda using CloudFormation Stack with parameters and template file / Configure API Gateway (GET&POST requests).
