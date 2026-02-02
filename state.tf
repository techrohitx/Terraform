# DAY-6----------------------------------------------------
terraform {
  backend "s3" {
    bucket = "terraform-backend-rr58-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1" #remote backend

  }
}
#root module
/*provider "aws" {
    region = "us-east-1" # remote block
  
}
resource "aws_instance" "myweb-1" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    key_name = "north-v-key1"
    tags = {
        Name = "web"
    }
  
}*/


# terraform state commands ➡️
# terraform state pull
# terraform state list
# terraform state show <resource_address> ex -> terraform state show aws_instance.myweb
# terraform state mv ex -> terraform state mv aws_instance.myweb aws_instance.myweb-1
# terraform state rm ex -> terraform state rm aws_instance.myweb-1


