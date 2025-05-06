import boto3
from datetime import datetime
from time import sleep

boto3.setup_default_session(profile_name="xxxxxxxxx")
cloudwatchlogs_client = boto3.client('logs')

def get_log_groups(next_token=None):
    log_group_request = {
        'limit': 50
    }
    if next_token:
        log_group_request['nextToken'] = next_token
    log_groups_response = cloudwatchlogs_client.describe_log_groups(**log_group_request)
    if log_groups_response:
        for log_group in log_groups_response['logGroups']:
            yield log_group
        if 'nextToken' in log_groups_response:
            yield from get_log_groups(log_groups_response['nextToken'])

def get_streams(log_group, next_token=None):
    log_stream_request = {
        'logGroupName': log_group['logGroupName'],
        'limit': 50 
    }
    if next_token:
        log_stream_request['nextToken'] = next_token

    response = cloudwatchlogs_client.describe_log_streams(**log_stream_request)

    if response:
        for log_stream in response['logStreams']:
            yield log_stream
        if 'nextToken' in response:
            yield from get_streams(log_group, response['nextToken'])

def delete_old_streams(log_group):
    if 'retentionInDays' not in log_group:
        print("log group {} has infinite retention, skipping".format(log_group['logGroupName']) )
        return

    for log_stream in get_streams(log_group):

        if 'lastEventTimestamp' not in log_stream:
            continue
        else:
            diff_millis = datetime.now().timestamp() * 1000 - log_stream['lastIngestionTime']
            diff_days = diff_millis / (1000 * 86400)
            
        if diff_days > log_group['retentionInDays']:
                print("Deleting stream: {} in log group {} ".format(log_stream['logStreamName'], log_group['logGroupName']))
                try:
                    # cloudwatchlogs_client.delete_log_stream(
                    #     logGroupName=log_group['logGroupName'],
                    #     logStreamName=log_stream['logStreamName']
                    # )
                    print("Stream deleted")
                    sleep(0.2)
                except Exception as e:
                    if e.response['Error']['Message'] == "Rate exceeded":
                        print("We've hit a rate limit error so we are stopping for this log group.")
                    else:
                        print("Error deleting log stream", e.response['Error']['Message'])
                    return

        
def lambda_handler(event, context):
    for log_group in get_log_groups():
        delete_old_streams(log_group)
    print("Done")


lambda_handler("dsfsd","fsdfds")