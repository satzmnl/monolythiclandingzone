rgs = {
    rg1 = {
        name     = "SATTAR_RESOURCE_GROUP"
        location = "Australia East"
          }
    rg2 = {
        name     = "SATTAR_RESOURCE_GROUP2"
        location = "Australia East"
          }
}

 vnets = {
        vnet1 = {
        name                = "SATTAR_VNET"
        location            = "Australia East"
        resource_group_name = "SATTAR_RESOURCE_GROUP"
        address_space       = ["10.1.0.0/16"]
                }
            }

subnets = {
    snet1 = {
      name                 = "frontend-subnet"
      resource_group_name  = "SATTAR_RESOURCE_GROUP"
      virtual_network_name = "SATTAR_VNET"
      address_prefixes     = ["10.1.1.0/24"]
             }

    snet2 = {
      name                 = "backend-subnet"
      resource_group_name  = "SATTAR_RESOURCE_GROUP"
      virtual_network_name = "SATTAR_VNET"
      address_prefixes     = ["10.1.2.0/24"]
            }
    }

vms = {
    vm1 = {
      nic_name      = "nic-frontend-vm"
      location  = "Australia East"
      rg_name   = "SATTAR_RESOURCE_GROUP"
      subnet_name  = "frontend-subnet"
      virtual_network_name = "SATTAR_VNET"
      pip_name     = "pip-chor-frontend-vm"
      vm_name     = "vm-frontend"
      vm_size     = "Standard_D4_v5"
      admin_username = "devopsadmin"
      admin_password = "Password@123"
          }
     vm2 = {
      nic_name      = "nic-backend-vm"
      location  = "Australia East"
      rg_name   = "SATTAR_RESOURCE_GROUP"
      subnet_name  = "backend-subnet"
      virtual_network_name = "SATTAR_VNET"
      pip_name     = "pip-chor-backend-vm"
      vm_name     = "vm-backend"
      vm_size     = "Standard_D4_v5"
      admin_username = "devopsadmin"
      admin_password = "Password@123"
    }
}
