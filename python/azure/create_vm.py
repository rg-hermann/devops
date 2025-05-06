from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.resource import ResourceManagementClient

RESOURCE_GROUP = "myResourceGroup"
LOCATION = "eastus"
VM_NAME = "myVM"

def create_vm():
    credential = DefaultAzureCredential()
    resource_client = ResourceManagementClient(credential, "<subscription_id>")
    compute_client = ComputeManagementClient(credential, "<subscription_id>")

    resource_client.resource_groups.create_or_update(RESOURCE_GROUP, {"location": LOCATION})

    compute_client.virtual_machines.begin_create_or_update(
        RESOURCE_GROUP,
        VM_NAME,
        {
            "location": LOCATION,
            "hardware_profile": {"vm_size": "Standard_B1s"},
            "storage_profile": {
                "image_reference": {
                    "publisher": "Canonical",
                    "offer": "UbuntuServer",
                    "sku": "18.04-LTS",
                    "version": "latest",
                }
            },
            "os_profile": {
                "computer_name": VM_NAME,
                "admin_username": "azureuser",
                "admin_password": "P@ssw0rd1234",
            },
            "network_profile": {
                "network_interfaces": [
                    {
                        "id": "/subscriptions/<subscription_id>/resourceGroups/myResourceGroup/providers/Microsoft.Network/networkInterfaces/myNic"
                    }
                ]
            },
        },
    )

if __name__ == "__main__":
    create_vm()
