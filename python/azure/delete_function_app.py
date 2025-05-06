from azure.identity import DefaultAzureCredential
from azure.mgmt.web import WebSiteManagementClient

RESOURCE_GROUP = "myResourceGroup"
FUNCTION_APP_NAME = "myFunctionApp123"

def delete_function_app():
    credential = DefaultAzureCredential()
    web_client = WebSiteManagementClient(credential, "<subscription_id>")

    web_client.web_apps.delete(RESOURCE_GROUP, FUNCTION_APP_NAME)
    print(f"Function App {FUNCTION_APP_NAME} deleted successfully.")

if __name__ == "__main__":
    delete_function_app()
