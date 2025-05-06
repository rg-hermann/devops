import boto3
from datetime import datetime, timedelta
from pprint import pp

boto3.setup_default_session(profile_name="xxxxxxxx")

def list_inactive_lambdas():
    lambda_client = boto3.client('lambda')
    logs_client = boto3.client('logs')
    
    now = datetime.utcnow()
    one_year_ago = now - timedelta(days=365)
    
    inactive_lambdas = []
    
    next_marker = None
    
    while True:

        if next_marker:
            response = lambda_client.list_functions(MaxItems=1000, Marker=next_marker)
        else:
            response = lambda_client.list_functions(MaxItems=1000)
        
        for function in response['Functions']:
            function_name = function['FunctionName']
            log_group_name = f'/aws/lambda/{function_name}'
            
            try:
        
                log_streams = logs_client.describe_log_streams(
                    logGroupName=log_group_name,
                    orderBy='LastEventTime',
                    descending=True,
                    limit=1
                )
                
        
                if log_streams['logStreams']:
                    last_event_time = log_streams['logStreams'][0]['lastEventTimestamp']
                    last_event_time = datetime.utcfromtimestamp(last_event_time / 1000.0)
                    
            
                    if last_event_time < one_year_ago:
                        inactive_lambdas.append(function_name)
                else:
            
                    inactive_lambdas.append(function_name)
            
            except logs_client.exceptions.ResourceNotFoundException:
        
                inactive_lambdas.append(function_name)
        

        if 'NextMarker' in response:
            next_marker = response['NextMarker']
        else:
            break
    
    return inactive_lambdas
inactive_lambdas = list_inactive_lambdas()
print("Funções Lambda inativas há mais de um ano:")
pp(inactive_lambdas)
pp(len(inactive_lambdas))
