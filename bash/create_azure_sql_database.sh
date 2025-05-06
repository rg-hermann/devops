#!/bin/bash
RESOURCE_GROUP="myResourceGroup"
SERVER_NAME="mySqlServer$RANDOM"
DATABASE_NAME="myDatabase"
LOCATION="eastus"
ADMIN_USER="adminuser"
ADMIN_PASSWORD="P@ssw0rd1234"

echo "Criando servidor SQL..."
az sql server create --name $SERVER_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --admin-user $ADMIN_USER --admin-password $ADMIN_PASSWORD

echo "Criando banco de dados..."
az sql db create --resource-group $RESOURCE_GROUP --server $SERVER_NAME --name $DATABASE_NAME --service-objective S0

echo "Banco de dados criado com sucesso!"
