provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}

resource "aws_instance" "demo" {
  ami           = "ami-0da9a208c352ca999" # 2025年06月
  instance_type = "t2.micro"
  key_name      = "okamuuu-dev"

  tags = {
    Name = "terraform-ec2-demo"
  }
}
