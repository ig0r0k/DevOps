# Create a new instance of the latest Ubuntu 14.04

provider "aws" {
  region = "us-east-2"
  access_key = ""
  secret_key = ""
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
  security_groups = ["${aws_security_group.instance.id}", "${aws_security_group.allow_http.id}"]
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

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

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

resource "aws_security_group" "instance" {
  name = "allow_SSH"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "test" {
  name               = "task11LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.allow_http.id}"]
  subnets            = ["subnet-38d3a742", "subnet-3eb88656"]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "test" {
  name     = "task11TARGET"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-25c5d34d"
  target_type = "instance"
}

resource "aws_lb_listener" "task11-Listener" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.test.arn}"
    type             = "forward"
  }
}
