# Create a new instance of the latest Ubuntu 14.04

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  name          = "task11"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name	= "task11"
  #vpc_classic_link_id = "${aws_vpc.main.id}"
  #vpc_classic_link_security_groups = ["${aws_security_group.allow_tls.id}"]
}

resource "aws_autoscaling_group" "bar" {
  name                 = "autoscale_task11"
  availability_zones = ["us-east-2c","us-east-2b", "us-east-2a"]
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  health_check_grace_period = 100
  health_check_type         = "ELB"
  force_delete              = true
  min_size             = 1
  max_size             = 2
  #vpc_zone_identifier  = ["${aws_subnet.main.*.id}", "${aws_subnet.second.*.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "test" {
  name     = "target11"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-2c"
}

resource "aws_subnet" "second" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.20.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "test" {
  name               = "lb11"
  internal           = false
  load_balancer_type = "application"
  enable_deletion_protection = false
  subnets            = ["${aws_subnet.main.*.id}", "${aws_subnet.second.*.id}"]
  security_groups    = ["${aws_security_group.allow_http.id}"]
}
