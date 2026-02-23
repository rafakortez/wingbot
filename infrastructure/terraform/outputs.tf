output "reserved_ip" {
  description = "IP fixo do servidor (usar este no DNS e no Ansible inventory)"
  value       = digitalocean_reserved_ip.trading.ip_address
}

output "droplet_id" {
  description = "ID do droplet no DigitalOcean"
  value       = digitalocean_droplet.trading.id
}

output "ssh_command" {
  description = "Comando para conectar via SSH"
  value       = "ssh -p ${var.ssh_port} -i ~/.ssh/nova_kygen root@${digitalocean_reserved_ip.trading.ip_address}"
}
