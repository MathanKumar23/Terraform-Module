# why null-resource -  to run scripts without recreating instances.
# terraform taint null_resource.vm_script - it will taint the resource, so will recreate it in next apply

resource "null_resource" "vm_script" {
  count = var.environment == "prod" ? 2 : 1

  provisioner "file" {
    source      = var.script_path
    destination = "/tmp/userdata.sh"
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = file(var.pem_file_path)
      host        = azurerm_linux_virtual_machine.public_vm[count.index].public_ip_address
    }
  }


  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/userdata.sh",
      "sudo /tmp/userdata.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y",
    ]
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = file(var.pem_file_path)
      host        = azurerm_linux_virtual_machine.public_vm[count.index].public_ip_address
    }
  }
  depends_on = [azurerm_linux_virtual_machine.public_vm]
}
