# provider "aws" {region = "us-east-1"} #first mension provider block

#Day-2---------------------------------------------------------------------------------------------------

/*resource "local_file" "pet" {
    filename = "/root/demo.txt"
    content = "this is my demo file"
}*/

#Day-3----------------------------------------------------------------------------------------------------

/*resource "aws_instance" "webserver" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t3.micro"
  key_name = "north-v-key1"
  tags = {
    Name = "webapp"
  }
}*/
/*resource "aws_instance" "webserver" {
    ami = "ami-0cae6d6fe6048ca2c"
    count = 3 # for 3 server launch at a time
    instance_type = "t3.micro"
  key_name = "north-v-key1"
  tags = {
    Name = "appserver${count.index}"#.index+1 for name start 1
  }
}*/
/*resource "aws_instance" "webserver" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t3.micro"
  key_name = "north-v-key1"
  for_each = toset(["appserver","webserver1","dbserver"]) #for diffrant name launch ec2
  tags = {
    Name = each.key #call the each function
  }
}*/
#Day4-------------------------------------------------------------------------------------------------------

/*resource "aws_instance" "myweb" {
  ami = "ami-0cae6d6fe6048ca2c"
  instance_type = "t3.micro"
  key_name = "north-v-key1"
 # vpc_security_group_ids = ["sg-0dff375f4dc7b5e01","sg-071d8c41871521a5e"] #use existing security group(created via aws console)copy sg id going to console
    vpc_security_group_ids = [aws_security_group.my-sg.id] # call resource block 
  tags = {
    Name = "webapp"
  }
}
resource "aws_security_group" "my-sg" {
  name = "tf-sg"
  ingress { #ingress it is a incomeing traffic
    description = "allow shh"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress { #ingress it is a incomeing traffic
    description = "allow http"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress { #ingress it is a incomeing traffic
    description = "allow https"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress { #egress it is a outgoing traffic
    description = "allow all traffic"
    to_port = 0 # for all traffic
    from_port = 0
    protocol = -1 # all kind of protocol
    cidr_blocks = ["0.0.0.0/0"] # anywhere
   }
   lifecycle {
     create_before_destroy = true
    
   }
  }*/
  