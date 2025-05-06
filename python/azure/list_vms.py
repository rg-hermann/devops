from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

RESOURCE_GROUP = "myResourceGroup"

def list_vms():
    credential = DefaultAzureCredential()
    compute_client = ComputeManagementClient(credential, "<subscription_id>")

    vms = compute_client.virtual_machines.list(RESOURCE_GROUP)
    for vm in vms:
        print(f"VM Name: {vm.name}")

if __name__ == "__main__":
    list_vms()
