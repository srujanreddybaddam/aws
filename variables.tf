variable "ami_id" {
  type = string
  default = "ami-0ca2e925753ca2fb4"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/20"
}

variable "cidr_block1" {
  type = string
  default = "10.0.0.0/24"
}

variable "sg" {
  type = string
  default = "example"
}