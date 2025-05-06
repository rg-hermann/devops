#!/bin/bash
RESOURCE_GROUP="myResourceGroup"
STORAGE_ACCOUNT_NAME="mystorageaccount$RANDOM"
LOCATION="eastus"

echo "Criando conta de armazenamento..."
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS

echo "Conta de armazenamento criada com sucesso: $STORAGE_ACCOUNT_NAME"
