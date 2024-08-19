variable "AWS_REGION" {
  default = "eu-west-1"
}

# Data source to fetch the latest Ubuntu 22.04 AMI in the specified region
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID
}

# You can access the AMI ID like this
output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}


