provider "aws" {
  region  = var.region
}

resource "aws_instance" "demo" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.demo.key_name
  vpc_security_group_ids = [aws_security_group.demo.id]
  user_data = <<-EOF
		#! /bin/bash
        apt update -y
        apt install default-jdk -y
        wget -qO - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
        sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
        apt update -y
        apt install jenkins -y
        systemctl start jenkins
        sudo apt update -y
        sudo apt install nginx -y
        sudo systemctl start nginx

 EOF
  
  
  tags =  {
    Name                  = "demo"
    Project               = var.project_tag
    Infra                 = var.infra_tag
    ManagedBy             = var.managedby_tag
    Env                   = var.env_tag
  }       
}