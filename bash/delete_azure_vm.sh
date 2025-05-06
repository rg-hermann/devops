#!/bin/bash
RESOURCE_GROUP="myResourceGroup"
VM_NAME="myVM"

echo "Deletando máquina virtual..."
az vm delete --resource-group $RESOURCE_GROUP --name $VM_NAME --yes --no-wait

echo "Máquina virtual deletada com sucesso!"
