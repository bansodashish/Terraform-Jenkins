variable "aws_region" {
  default = "us-west-2"
}

variable "access_key" {
default = "AKIAJK2WVLIKR42Y4TUQ"

}
variable "secret_key" {
default = "zEdd8spBUVvPPycfF4U4mj/WxAqC8M5x7c3DC0BQ"

}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "azs" {
  type    = "list"
  default = ["us-west-2a", "us-west-2b"]
}

variable "webserver_ami" {
default = "ami-e689729e"
}

variable "instance_type" {
default = "t2.micro"
}
