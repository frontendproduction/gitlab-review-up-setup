terraform {
  required_version = ">= 1.11.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "wefp-tf-backend"
    region                      = "ru-central1"
    key                         = "states/wefp/state.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  zone                     = "ru-central1-d"
  service_account_key_file = var.service_account_key_file
}
