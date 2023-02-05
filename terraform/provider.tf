terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
  }
  backend "gcs" {
    bucket = "kubernetes-terraform-state-bucket"
    prefix = "instance_group_switch"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}