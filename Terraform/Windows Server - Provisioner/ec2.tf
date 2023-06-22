# Get Latest Windows Servers
  # Get latest Windows Server 2012R2 AMI
  data "aws_ami" "windows-2012-r2" {
    most_recent = true
    owners      = ["amazon"]
    filter {
      name   = "name"
      values = ["Windows_Server-2012-R2_RTM-English-64Bit-Base-*"]
    }
  }
  # Get latest Windows Server 2016 AMI
  data "aws_ami" "windows-2016" {
    most_recent = true
    owners      = ["amazon"]
    filter {
      name   = "name"
      values = ["Windows_Server-2016-English-Full-Base*"]
    }
  }
  # Get latest Windows Server 2019 AMI
  data "aws_ami" "windows-2019" {
    most_recent = true
    owners      = ["amazon"]
    filter {
      name   = "name"
      values = ["Windows_Server-2019-English-Full-Base*"]
    }
  }
  # Get latest Windows Server 2022 AMI
  data "aws_ami" "windows-2022" {
    most_recent = true
    owners      = ["amazon"]
    filter {
      name   = "name"
      values = ["Windows_Server-2022-English-Full-Base*"]
    }
  }
#

# Bootstrapping PowerShell Script
data "template_file" "windows_userdata" {
  template = <<EOF
<powershell>
# Rename Machine
Rename-Computer -NewName "${var.windows_instance_name}" -Force;
# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;
# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}

# Create EC2 Instance
resource "aws_instance" "windows_server" {
  ami = data.aws_ami.windows-2019.id
  instance_type = var.windows_instance_type
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.aws-windows-sg.id]
  source_dest_check = false
  key_name = aws_key_pair.key_pair.key_name
  user_data = data.template_file.windows_userdata.rendered 
  associate_public_ip_address = var.windows_associate_public_ip_address
  
  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }
  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.windows_data_volume_size
    volume_type           = var.windows_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }
  
  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }
}

# Create Elastic IP for the EC2 instance
resource "aws_eip" "windows-eip" {
  vpc  = true
  tags = {
    Name = "windows-eip"
  }
}
# Associate Elastic IP to Windows Server
resource "aws_eip_association" "windows-eip-association" {
  instance_id   = aws_instance.windows_server.id
  allocation_id = aws_eip.windows-eip.id
}
