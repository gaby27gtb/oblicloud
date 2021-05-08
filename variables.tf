variable "region"{
    default ="us-east-1"
}
variable "az-1a"{
    default ="us-east-1a"
}

variable "az-1b"{
    default ="us-east-1b"
}

variable "az-1c"{
    default ="us-east-1c"
}

variable "ami" {
    default = "ami-00e87074e52e6c9f9"
  
}


variable "instance_type" {
    default = "t2.micro"
  
}

variable "key_name" {
    default = "instancia1"
  
}
