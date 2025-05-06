from azure.identity import DefaultAzureCredential
from azure.mgmt.storage import StorageManagementClient

RESOURCE_GROUP = "myResourceGroup"
STORAGE_ACCOUNT_NAME = "mystorageaccount123"

def delete_storage_account():
    credential = DefaultAzureCredential()
    storage_client = StorageManagementClient(credential, "<subscription_id>")

    storage_client.storage_accounts.delete(RESOURCE_GROUP, STORAGE_ACCOUNT_NAME)
    print(f"Storage account {STORAGE_ACCOUNT_NAME} deleted successfully.")

if __name__ == "__main__":
    delete_storage_account()
