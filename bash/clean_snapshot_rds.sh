#!/bin/bash
DB_INSTANCE_IDENTIFIER="xxxxxxxxx"
KEEP_LAST=3

echo "Listando snapshots..."
SNAPSHOTS=$(aws rds describe-db-snapshots --db-instance-identifier $DB_INSTANCE_IDENTIFIER --query 'DBSnapshots[].[DBSnapshotIdentifier,SnapshotCreateTime]' --output text | sort -k2 | head -n -$KEEP_LAST)

for SNAPSHOT in $SNAPSHOTS; do
  echo "Excluindo snapshot $SNAPSHOT"
  aws rds delete-db-snapshot --db-snapshot-identifier $SNAPSHOT
done

echo "Limpeza concluída."
