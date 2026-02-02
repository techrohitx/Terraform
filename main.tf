#DAY-5--------------------------------------------------------------
provider "aws" {
  region = "us-east-1"

}
# dynamic assignment
/*resource "aws_instance" "myweb" {
    ami = var.my_ami #use/call
    instance_type = var.my_instance #use/call
    count = 3
    for_each = tomap("app=appserver","web=webserver","db=dbserver") # for app=key and appserver=value 
    key_name = var.my_key #use/call
    vpc_security_group_ids = var.my_sg #use/call
    #list -> index
    availability_zone = var.my_az[0] # use index
    tags = {
    Name =  each.value# hardcoding
   # Name = each.key
    }
}
resource "local_file" "fruit_file" {
    filename = var.my_file
    #map -> using key
    content = var.my_content[stamenet2] # use key
}*/
#*********************************************************************************************
# user data script
/*resource "aws_instance" "new_web" {
    ami = var.my_ami #use/call
    instance_type = var.my_instance #use/call
    key_name = var.my_key #use/call
    vpc_security_group_ids = var.my_sg #use/callfor_each
    availability_zone = var.my_az[0] 
     #heredoc
user_data = <<-EOF
             #!/bin/bash
             sudo yum update
             sudo yum install httpd -y
             sudo systemctl start httpd
             cd /var/www/html
             echo "<h1>This is httpd server</h1>" > index.html           
            EOF
    tags = {
    Name =  "newserver"
           }
}*/
#***********************************************************************************************
# Data Block
/*resource "aws_instance" "new_web" {
    ami = var.my_ami #use/call
    instance_type = var.my_instance #use/call
    key_name = var.my_key #use/call
    vpc_security_group_ids =[data.aws_security_group.aws-sg.name]    #var.my_sg  #use/callfor_each
    availability_zone = var.my_az[0] 
    tags = {
      Name =  "newserver"
           }
}
# to read the data from aws and it attaches the resources of aws to teeraform resosource
data "aws_security_group" "aws-sg" {
    name = "launch-wizard-4"
    vpc_id = "vpc-0eac76556790f5173"
  
}*/ # to read the data
## terraform import it is manage outside the terraform resources 
/*resource "aws_instance" "aws_web" {
ami = "ami-068c0051b15cdb816"
instance_type = "t2.micro"
vpc_security_group_ids = ["sg-0dff375f4dc7b5e01"]
key_name = "north-v-key1"
tags = {
  Name = "console"
}
}# after that use terraform import aws_instance.aws_web i-08b207441a8d56696 -> this is server id 

resource "aws_security_group" "aws_sg" {
    name = "server_sg"
    vpc_id = "vpc-0eac76556790f5173"
    ingress{
        description = "allow http, shh"
        to_port = 22
        from_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        description = "allow http, shh"
        to_port = 80
        from_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        description = "allow all traffic"
        to_port = 0
        from_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    lifecycle {
      create_before_destroy = true
    }
}*/ #after that use terraform import aws_security_group.aws_sg sg-0dff375f4dc7b5e01 -> this is security group id 
# provisioner -> local
/*resource "aws_instance" "my-web" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    key_name = "north-v-key1" #public key
    provisioner "local-exec" { # create file and stored public ip
command = "echo ${self.public_ip} >> public_ip.txt" 
}
tags = {
  Name = "webserver"
}
}*/
# provisioner -> remote

/*resource "aws_instance" "my-web1" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    key_name = "north-v-key1" #public key
    provisioner "remote-exec" { # create file and stored public ip
inline = [ 
    "sudo yum update",
    "sudo yum install nginx -y",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx"
    ]
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file("D:/sshkey/north-v-key1.pem")
    }
    }
    tags = {
        Name = "webserver"
    }
  
}*/
# DAY-7--------------------------------------------------------------------------------
# provisioner -> file

/*resource "aws_instance" "my-web2" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    key_name = "north-v-key1"
provisioner "file" {
 source = "public_ip.txt"
 destination = "/tmp/public_ip.txt"
}
connection {
  type = "ssh"
  host = self.public_ip
  user = "ec2-user"
  private_key = file("D:/sshkey/north-v-key1.pem")
}
}*/

# terraform taint
/*resource "aws_instance" "my-web1" {
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t2.micro"
  key_name      = "north-v-key1"
  tags = {
    Name = "web1"
  }
}
resource "aws_instance" "my-web2" {
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t2.micro"
  key_name      = "north-v-key1"
  tags = {
    Name = "web2"
  }
}
resource "aws_instance" "my-web3" {
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t2.micro"
  key_name      = "north-v-key1"
  tags = {
    Name = "web3"
  }
}*/
# below commant for destroy instance and recreating
# terraform taint aws_instance.my-web1 
# terraform apply -replace="aws_instance.my-web2"
# terrafor fmt  they use  formating of code
# modules
module "ec2_instance" {
    source = "./modules/"
    instance_type = "t3.micro"
  
}