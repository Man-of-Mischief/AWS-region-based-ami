provider "aws" {
  region     = var.region
}
 
## variables.tf
 
/* variable "ohio-ami" {
  default     = "ami-08333bccc35d71140"
}
 
variable "mumbai-ami" {
  default     = "ami-0b08bfc6ff7069aff"
} */
 
variable "instance_type" {
  default     = "t2.micro"
}
 
variable "ami"{
    type = map
    default = {
        "ap-south-1" = "ami-08333bccc35d71140",
        "us-east-2" = "ami-0b08bfc6ff7069aff"
    }
}
 
variable "region"{
    default = "ap-south-1"                                           ########### we can use this in ami section to set region
}
 
### main.tf
 
################# EC2 INSTANCE CREATION ####################
 
resource "aws_instance" "webserver" {
  ami                    = var.ami[var.region]
  availability_zone      = var.region
  instance_type          = var.instance_type
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = ["aws_security_group.webserver.id"]
  tags = {
    Name      = "webserver"
    "project" = "devops"
    "env"     = "dev"
  }
}
 
 
################# SG CREATION ####################
 
 
 
resource "aws_security_group" "webserver" {
  name        = "webserver"
  description = "Allow ssh, http and https traffic"
 
  ingress {
    description      = "HTTPS Port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  ingress {
    description      = "HTTP Port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Name      = "webserver"
    "project" = "zomato"
    "env"     = "dev"
  }
}
 
################# KEYPAIR CREATION ####################
 
resource "aws_key_pair" "mykey" {
  key_name   = "zomato"
  public_key = file("zomato-keypair.pub")
  tags = {
    Name      = "zomato"
    "project" = "zomato"
    "env"     = "dev"
  }
}
 
 
data "aws_region" "current" {}                                          ########### used to get the current region we are working on
 
output "region"{
    value = data.aws_region.current.name                                ########### gives current region as output, we can use this in ami section to set region.
}
