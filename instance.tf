############################## Instance ###############################################

resource "aws_instance" "foo" {
  ami             = "ami-0f403e3180720dd7e" # ap-south1
  subnet_id       = aws_subnet.my_subnet.id
  instance_type   = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.my_sg.id]

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2_AVAIL_ZONE=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo "<h3>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h3>" > /var/www/html/index.html
EOF


  tags = {
    Name = "tf-instance-foo"
  }


}

######################---------------------------##########################################################

resource "aws_instance" "bar" {
  ami             = "ami-0f403e3180720dd7e" # ap-south1
  subnet_id       = aws_subnet.my_subnet1.id
  instance_type   = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.my_sg.id]

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2_AVAIL_ZONE=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo "<h3>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h3>" > /var/www/html/index.html
EOF


  tags = {
    Name = "tf-instance-bar"
  }


}
