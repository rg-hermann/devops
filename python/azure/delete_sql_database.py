from azure.identity import DefaultAzureCredential
from azure.mgmt.sql import SqlManagementClient

RESOURCE_GROUP = "myResourceGroup"
SERVER_NAME = "mySqlServer123"
DATABASE_NAME = "myDatabase"

def delete_sql_database():
    credential = DefaultAzureCredential()
    sql_client = SqlManagementClient(credential, "<subscription_id>")

    sql_client.databases.delete(RESOURCE_GROUP, SERVER_NAME, DATABASE_NAME)
    print(f"SQL Database {DATABASE_NAME} deleted successfully.")

if __name__ == "__main__":
    delete_sql_database()
