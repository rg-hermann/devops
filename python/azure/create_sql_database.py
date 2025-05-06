from azure.identity import DefaultAzureCredential
from azure.mgmt.sql import SqlManagementClient

RESOURCE_GROUP = "myResourceGroup"
SERVER_NAME = "mySqlServer123"
DATABASE_NAME = "myDatabase"
LOCATION = "eastus"

def create_sql_database():
    credential = DefaultAzureCredential()
    sql_client = SqlManagementClient(credential, "<subscription_id>")

    sql_client.servers.begin_create_or_update(
        RESOURCE_GROUP,
        SERVER_NAME,
        {
            "location": LOCATION,
            "administrator_login": "adminuser",
            "administrator_login_password": "P@ssw0rd1234",
        },
    )

    sql_client.databases.begin_create_or_update(
        RESOURCE_GROUP,
        SERVER_NAME,
        DATABASE_NAME,
        {"location": LOCATION, "sku": {"name": "S0"}},
    )
    print(f"SQL Database {DATABASE_NAME} created successfully.")

if __name__ == "__main__":
    create_sql_database()
