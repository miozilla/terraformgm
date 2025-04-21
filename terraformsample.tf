terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # Adjust version based on requirements
    }
  }
}

provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
  credentials = file("your-service-account.json")
}

module "vm_instance" {
  source     = "terraform-google-modules/vm/google"
  version    = "~> 7.0"
  instance_name = "example-instance"
  machine_type  = "n1-standard-1"
  zone         = "us-central1-a"
  tags         = ["web", "production"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
    }
  }

  network_interfaces {
    network    = "default"
    subnetwork = "default"
    access_config {
      nat_ip = null # Assigns an ephemeral IP
    }
  }
}