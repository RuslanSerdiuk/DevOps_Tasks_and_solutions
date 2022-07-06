data "aws_ami" "latest_amazon" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "Bastion_Host" {
  ami                    = data.aws_ami.latest_amazon.id
  instance_type          = var.bastion_instance_type
  vpc_security_group_ids = [var.security_group_ec2_id_bastion, var.security_group_ec2_id_ssh]
  subnet_id              = var.vpc_public_subnets_b_id_ec2
  user_data              = templatefile(var.path_bastion_user_data, {
    pub_key = var.public_key
   })
  key_name               = var.bastion_key_name

  tags = {
    Name = "${var.name}_My_Bastion_Server"
  }
}