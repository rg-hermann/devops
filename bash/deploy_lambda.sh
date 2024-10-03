#!/bin/bash
FUNCTION_NAME="xxxxxxxxxx"
ZIP_FILE="xxxxxxxxxx.zip"
ROLE_ARN="arn:aws:iam::xxxxxxxxx:role/lambda-role"

echo "Empacotando código..."
zip -r $ZIP_FILE .

echo "Fazendo upload para Lambda..."
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$ZIP_FILE

echo "Atualizando configuração da função..."
aws lambda update-function-configuration --function-name $FUNCTION_NAME --role $ROLE_ARN

echo "Deploy concluído!"
