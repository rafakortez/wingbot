variable "do_token" {
  description = "DigitalOcean API token (gerar em: https://cloud.digitalocean.com/account/api/tokens)"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "Conteúdo da chave pública SSH (nova_kygen.pub)"
  type        = string
}

variable "droplet_name" {
  description = "Nome do droplet"
  type        = string
  default     = "VM-ubuntu"
}

variable "region" {
  description = "Região do DigitalOcean"
  type        = string
  default     = "nyc1"
}

variable "droplet_size" {
  description = "Tamanho do droplet"
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "ssh_port" {
  description = "Porta SSH customizada (diferente de 22)"
  type        = number
  default     = 2277
}
