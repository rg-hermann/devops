from azure.identity import DefaultAzureCredential
from azure.mgmt.web import WebSiteManagementClient

RESOURCE_GROUP = "myResourceGroup"
FUNCTION_APP_NAME = "myFunctionApp123"
STORAGE_ACCOUNT_NAME = "mystorageaccount123"
LOCATION = "eastus"

def create_function_app():
    credential = DefaultAzureCredential()
    web_client = WebSiteManagementClient(credential, "<subscription_id>")

    web_client.web_apps.begin_create_or_update(
        RESOURCE_GROUP,
        FUNCTION_APP_NAME,
        {
            "location": LOCATION,
            "server_farm_id": "/subscriptions/<subscription_id>/resourceGroups/myResourceGroup/providers/Microsoft.Web/serverfarms/myPlan",
            "site_config": {"app_settings": [{"name": "AzureWebJobsStorage", "value": STORAGE_ACCOUNT_NAME}]},
        },
    )
    print(f"Function App {FUNCTION_APP_NAME} created successfully.")

if __name__ == "__main__":
    create_function_app()
