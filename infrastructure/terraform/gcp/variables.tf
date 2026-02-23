variable "gcp_project" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_credentials_file" {
  description = "Caminho para o JSON de credenciais do GCP Service Account"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona GCP (us-central1-a é free tier)"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "Tipo de máquina (e2-micro = free tier)"
  type        = string
  default     = "e2-small"
}

variable "ssh_public_key" {
  description = "Conteúdo da chave pública SSH"
  type        = string
}

variable "ssh_port" {
  description = "Porta SSH customizada"
  type        = number
  default     = 2277
}
