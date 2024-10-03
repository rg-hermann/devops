#!/bin/bash
INSTANCE_ID="xxxxxxxxxx"
CPU_THRESHOLD=80

CPU_USAGE=$(aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization \
--dimensions Name=InstanceId,Value=$INSTANCE_ID --statistics Average --start-time $(date -u -d '5 minutes ago' +%Y-%m-%dT%H:%M:%SZ) \
--end-time $(date -u +%Y-%m-%dT%H:%M:%SZ) --period 300 --query 'Datapoints[0].Average' --output text)

if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" |bc -l) )); then
  echo "CPU usage is $CPU_USAGE%. Scaling up..."
  aws autoscaling set-desired-capacity --auto-scaling-group-name my-auto-scaling-group --desired-capacity 2
else
  echo "CPU usage is $CPU_USAGE%. No scaling needed."
fi
