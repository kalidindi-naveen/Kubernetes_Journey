variable "common_tags" {
  type = map(any)
  default = {
    Name     = "workstation",
    Environment = "dev",
    Terraform   = "true"
  }
}

variable "subnet_id" {
  type = string
  default = "subnet-0308d9dec69b7eecf"
}

variable "sg_ids" {
  type = list(string)
  default = [ "sg-001eb7a1302998ada" ]
}