terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project
  region      = var.region
  zone        = var.zone
}

# ─── IP Estático ──────────────────────────────────────────────────────────────
resource "google_compute_address" "trading" {
  name   = "wingtradebot-ip"
  region = var.region
}

# ─── Firewall ─────────────────────────────────────────────────────────────────
resource "google_compute_firewall" "allow_web" {
  name    = "wingtradebot-allow-web"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wingtradebot"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "wingtradebot-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = [tostring(var.ssh_port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wingtradebot"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "wingtradebot-allow-icmp"
  network = "default"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wingtradebot"]
}

# ─── VM (equivalente ao Droplet DO) ───────────────────────────────────────────
resource "google_compute_instance" "trading" {
  name         = "wingtradebot-test"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["wingtradebot"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 20  # GB
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Usa o IP estático reservado
      nat_ip = google_compute_address.trading.address
    }
  }

  metadata = {
    # Chave SSH injetada na VM — mesmo conceito do DigitalOcean
    ssh-keys = "root:${var.ssh_public_key}"
  }
}
