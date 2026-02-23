terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# ─── Chave SSH ────────────────────────────────────────────────────────────────
resource "digitalocean_ssh_key" "trading" {
  name       = "wingtradebot-key"
  public_key = var.ssh_public_key
}

# ─── Droplet ──────────────────────────────────────────────────────────────────
resource "digitalocean_droplet" "trading" {
  name      = var.droplet_name
  size      = var.droplet_size
  image     = "ubuntu-24-04-x64"
  region    = var.region
  ssh_keys  = [digitalocean_ssh_key.trading.fingerprint]

  tags = ["wingtradebot", "production"]
}

# ─── IP Reservado (não muda mesmo recriando o droplet) ────────────────────────
resource "digitalocean_reserved_ip" "trading" {
  region = var.region
}

resource "digitalocean_reserved_ip_assignment" "trading" {
  ip_address = digitalocean_reserved_ip.trading.ip_address
  droplet_id = digitalocean_droplet.trading.id
}

# ─── Firewall ─────────────────────────────────────────────────────────────────
# Substitui o ufw que estava desativado no servidor
resource "digitalocean_firewall" "trading" {
  name        = "wingtradebot-firewall"
  droplet_ids = [digitalocean_droplet.trading.id]

  # HTTPS — wingtradebot
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTP — Let's Encrypt challenge / redirect
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # SSH — porta customizada (não a 22)
  inbound_rule {
    protocol         = "tcp"
    port_range       = tostring(var.ssh_port)
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # ICMP — permite ping para diagnóstico
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Saída — tudo permitido (app chama APIs externas)
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
