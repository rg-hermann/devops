from azure.identity import DefaultAzureCredential
from azure.mgmt.storage import StorageManagementClient

RESOURCE_GROUP = "myResourceGroup"

def list_storage_accounts():
    credential = DefaultAzureCredential()
    storage_client = StorageManagementClient(credential, "<subscription_id>")

    accounts = storage_client.storage_accounts.list_by_resource_group(RESOURCE_GROUP)
    for account in accounts:
        print(f"Storage Account: {account.name}")

if __name__ == "__main__":
    list_storage_accounts()
