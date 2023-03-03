data "aws_ami" "latest_amazon" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}


#=====================================LAUNCH CONFIG=======================================#
#====================================IAM ROLE FOR S3======================================#
  resource "aws_iam_instance_profile" "TF-Epam-profile" {
    name = "${var.name}_TF_Epam_profile"
    role = aws_iam_role.TF_EC2S3Role.name
  }


  resource "aws_iam_role" "TF_EC2S3Role" {
    name = "TF_MyEC2S3Role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
    })

    tags = {
      tag-key = "tag-value"
    }
  }


  data "aws_iam_policy" "s3_policy_aws" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }


  resource "aws_iam_role_policy_attachment" "my_attach" {
    role       = aws_iam_role.TF_EC2S3Role.name
    policy_arn = data.aws_iam_policy.s3_policy_aws.arn
  }



  resource "aws_launch_configuration" "launch_conf" {
    name                 = "${var.name}_TF_Launch_Config"
    image_id             = data.aws_ami.latest_amazon.id
    instance_type        = var.launch_instance_type
    security_groups      = [var.security_group_asg_id_rds]
    user_data            = templatefile(var.path_user_data, {
      db_addr = var.database_addr
      s3_id   = var.s3_addr
      db_n    = var.db_name
      db_u    = var.db_user_name
      db_p    = var.db_pswd
      })
    
    key_name             = var.launch_key_name
    iam_instance_profile = aws_iam_instance_profile.TF-Epam-profile.id

    root_block_device {
      volume_type        = "gp2"
      volume_size        = 8
    }

    lifecycle {
      create_before_destroy = true
    }
  }


#======================================TARGET GROUP=======================================#
  resource "aws_lb_target_group" "EPAM_TG_80" {
    name     = "${var.name}-TF-EPAM-Target-Group"
    port     = 443
    protocol = "HTTPS"
    vpc_id   = var.vpc_id_asg
    
    health_check {
      healthy_threshold    = 5
      unhealthy_threshold  = 2
      timeout              = 5
      protocol             = "HTTPS"
      port                 = "traffic-port"
      interval             = "30"
    } 
  }

#=================================Application Load Balancer===============================#
  resource "aws_lb" "TF_Balancer" {
    name                 = "${var.name}-TF-Balancer"
    internal             = false
    load_balancer_type   = var.type_of_load_balancer
    security_groups      = [var.security_group_asg_id_bastion]
    subnets              = [var.vpc_public_subnets_a_id_asg, var.vpc_public_subnets_b_id_asg]

    tags = {
      Name = "${var.name}_TF_Balancer"
    }
  }


  resource "aws_lb_listener" "HTTP" {
    load_balancer_arn = aws_lb.TF_Balancer.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type = "redirect"

      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }


  resource "aws_lb_listener" "HTTPS" {
    load_balancer_arn = aws_lb.TF_Balancer.arn
    port              = "443"
    protocol          = "HTTPS"
    certificate_arn   = "arn:aws:acm:us-east-2:384461882996:certificate/7e0f4483-6063-4ba3-95e6-7efb4927d189"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.EPAM_TG_80.arn
    }
  }


  resource "aws_lb_listener_certificate" "example" {
    listener_arn    = aws_lb_listener.HTTPS.arn
    certificate_arn = "arn:aws:acm:us-east-2:384461882996:certificate/7e0f4483-6063-4ba3-95e6-7efb4927d189"
  }

#===================================Auto Scaling Group====================================#
  resource "aws_autoscaling_group" "ASG" {
    name                 = "${var.name}_TF_EPAM_ASG"
    launch_configuration = aws_launch_configuration.launch_conf.name
    min_size             = 1
    max_size             = 1
    #min_elb_capacity     = 1
    vpc_zone_identifier  = [var.vpc_private_subnets_b_id_asg, var.vpc_private_subnets_a_id_asg]
    health_check_type    = var.type_health_check
    target_group_arns    = [aws_lb_target_group.EPAM_TG_80.arn]

    dynamic "tag" {
      for_each = {
        Name   = "${var.name}_TF_EPAM_ASG"
        Owner  = "Ruslan Serdiuk"
        TAGKEY = "TAGVALUE"
      }
      content {
        key                 = tag.key
        value               = tag.value
        propagate_at_launch = true
      }
    }

    depends_on = [
      aws_iam_role.TF_EC2S3Role
    ]
    lifecycle {
      create_before_destroy = true
    }
  }

