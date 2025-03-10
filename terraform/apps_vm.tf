resource "yandex_vpc_network" "apps_network" {
  name = "apps_network"
}

resource "yandex_vpc_subnet" "apps_subnet" {
  name           = "apps_subnet"
  network_id     = yandex_vpc_network.apps_network.id
  zone           = "ru-central1-d"
  v4_cidr_blocks = ["192.168.0.0/24"]
}

data "yandex_compute_image" "docker_image" {
  family = "container-optimized-image"
}

resource "yandex_vpc_address" "wefp_ru_static_ip" {
  name = "wefp_ru_static_ip"
  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}

resource "yandex_compute_instance" "apps_vm" {
  name        = "apps_vm"
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.docker_image.id
      size     = 20
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.apps_subnet.id
    nat            = true
    nat_ip_address = yandex_vpc_address.wefp_ru_static_ip.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = <<EOF
      laland:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBC12jzxJSyrBiquyUAzccegwbEM5QDMSz2TAGMUzAjKA8rgnAB+qbbhXzLIWtjVnyYe6w3gn3G7YVPy0bL1+Atn72UIZpktsaJXdxNWVRAFbN0JrVLvq+QW1ktT9NNol3WarbvjrZ4DcHB9MMp8We2Q1vNtFmNPh/FHUZO2mcSAyMQBtQY6qld+Xbjj2PbAZF3V7auOdKFBFKx+qkGqVRhJT1RxS6Db1oDZXYcWT5PnbZLVW/vnN/jRwUS3n9b2leUg/F3lC23nRnDG/xi8cUiFvoHPAcUfsfn+qHQ8Z+ios0Q+bQ7fIuD1o/t5vkhHAGM60D1hfeourjIHv7mRmX revv@revv-bork
    EOF
  }
}

output "apps_vm_public_ip" {
  value = yandex_compute_instance.apps_vm.network_interface.0.nat_ip_address
}
