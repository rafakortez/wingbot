output "public_ip" {
  description = "IP público da VM GCP — usar no DuckDNS e no Ansible inventory"
  value       = google_compute_address.trading.address
}

output "ssh_command" {
  description = "Comando para conectar via SSH"
  value       = "ssh -p ${var.ssh_port} -i ~/.ssh/nova_kygen root@${google_compute_address.trading.address}"
}

output "update_duckdns" {
  description = "URL para atualizar o DuckDNS com o novo IP"
  value       = "https://www.duckdns.org/update?domains=winbot&token=SEU_TOKEN&ip=${google_compute_address.trading.address}"
}
