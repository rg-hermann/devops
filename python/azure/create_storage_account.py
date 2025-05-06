from azure.identity import DefaultAzureCredential
from azure.mgmt.storage import StorageManagementClient

RESOURCE_GROUP = "myResourceGroup"
STORAGE_ACCOUNT_NAME = "mystorageaccount123"
LOCATION = "eastus"

def create_storage_account():
    credential = DefaultAzureCredential()
    storage_client = StorageManagementClient(credential, "<subscription_id>")

    storage_client.storage_accounts.begin_create(
        RESOURCE_GROUP,
        STORAGE_ACCOUNT_NAME,
        {
            "sku": {"name": "Standard_LRS"},
            "kind": "StorageV2",
            "location": LOCATION,
        },
    )
    print(f"Storage account {STORAGE_ACCOUNT_NAME} created successfully.")

if __name__ == "__main__":
    create_storage_account()
