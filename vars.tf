variable "amis" {
  type = map

  default = {
    "us-east-1" = "ami-06e46074ae430fba6"
    "us-east-2" = "ami-0578f2b35d0328762"
  }
}

variable "cdirs_acesso_remoto" {
  type = list(string)

  default = [
    "YOUR_IP" # Preencher com o seu IP IPv4, i.e: xxx.xxx.xx.x/32
  ]
}

variable "key_name" {
  type = string

  default = "terraform-aws"
}
