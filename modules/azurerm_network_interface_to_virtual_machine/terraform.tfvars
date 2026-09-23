vms = {

  nic1 = {
    nic_name             = "frontend-vm-nic"
    location         = "Australia East"
    rg_name          = "SATTAR_RESOURCE_GROUP"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "SATTAR_VNET"
    pip_name             = "frontend-pip-vm"
    vm_name              = "frontend-vm"
    vm_size              = "Standard_D4_v5"
    admin_username       = "adminuser"
    admin_password       = "password1234"
  }

  nic2 = {
    nic_name             = "backend-vm-nic"
    location             = "Australia East"
    rg_name              = "SATTAR_RESOURCE_GROUP"
    subnet_name          = "backend-subnet"
    virtual_network_name = "SATTAR_VNET"
    pip_name             = "backend-pip-vm"
    vm_name              = "backend-vm"
    vm_size              = "Standard_D4_v5"
    admin_username       = "adminuser"
    admin_password       = "password1234"
  }
}
