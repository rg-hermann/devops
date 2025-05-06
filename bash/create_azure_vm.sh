#!/bin/bash
RESOURCE_GROUP="myResourceGroup"
VM_NAME="myVM"
LOCATION="eastus"
IMAGE="UbuntuLTS"
SIZE="Standard_B1s"

echo "Criando grupo de recursos..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Criando máquina virtual..."
az vm create --resource-group $RESOURCE_GROUP --name $VM_NAME --image $IMAGE --size $SIZE --generate-ssh-keys

echo "Máquina virtual criada com sucesso!"
