from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

RESOURCE_GROUP = "myResourceGroup"
VM_NAME = "myVM"

def delete_vm():
    credential = DefaultAzureCredential()
    compute_client = ComputeManagementClient(credential, "<subscription_id>")

    compute_client.virtual_machines.begin_delete(RESOURCE_GROUP, VM_NAME)
    print(f"VM {VM_NAME} deleted successfully.")

if __name__ == "__main__":
    delete_vm()
