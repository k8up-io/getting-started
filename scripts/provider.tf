terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "~> 0.22.0"
    }
  }
}

provider "exoscale" {}