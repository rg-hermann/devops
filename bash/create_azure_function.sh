#!/bin/bash
RESOURCE_GROUP="myResourceGroup"
STORAGE_ACCOUNT_NAME="mystorageaccount$RANDOM"
FUNCTION_APP_NAME="myFunctionApp$RANDOM"
LOCATION="eastus"
RUNTIME="node"

echo "Criando grupo de recursos..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Criando conta de armazenamento..."
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS

echo "Criando Function App..."
az functionapp create --resource-group $RESOURCE_GROUP --consumption-plan-location $LOCATION --runtime $RUNTIME --functions-version 4 --name $FUNCTION_APP_NAME --storage-account $STORAGE_ACCOUNT_NAME

echo "Azure Function criada com sucesso!"
