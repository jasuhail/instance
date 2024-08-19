# Define the three instances
resource "aws_instance" "control" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.medium"
  key_name      = "EC2Acces"
  subnet_id     = aws_subnet.openvpn-public-1.id
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]

  tags = {
    Name = "Control"
  }
}

resource "aws_instance" "node_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "EC2Acces"
  subnet_id     = aws_subnet.openvpn-public-1.id
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]

  tags = {
    Name = "Node-1"
  }
}

resource "aws_instance" "node_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "EC2Acces"
  subnet_id     = aws_subnet.openvpn-public-1.id
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]

  tags = {
    Name = "Node-2"
  }
}

# Output the public IPs of the instances if needed
output "control_instance_public_ip" {
  value = aws_instance.control.public_ip
}

output "node_1_instance_public_ip" {
  value = aws_instance.node_1.public_ip
}

output "node_2_instance_public_ip" {
  value = aws_instance.node_2.public_ip
}