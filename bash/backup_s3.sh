#!/bin/bash
SOURCE_BUCKET="xxxxxx"
DEST_BUCKET="xxxxxxxxx"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

echo "Iniciando backup do bucket $SOURCE_BUCKET para $DEST_BUCKET"
aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET/backup-$TIMESTAMP

echo "Backup concluído."
