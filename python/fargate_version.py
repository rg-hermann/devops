import boto3
boto3.setup_default_session(profile_name="xxxxxxxxxx")

ecs_client = boto3.client('ecs')

def get_fargate_versions():
    
    clusters_response = ecs_client.list_clusters(maxResults=100)
    clusters = clusters_response['clusterArns']
    
    for cluster_arn in clusters:
        
        tasks_response = ecs_client.list_tasks(cluster=cluster_arn, launchType='FARGATE',maxResults=100)
        task_arns = tasks_response['taskArns']

        if task_arns:
            
            tasks_details = ecs_client.describe_tasks(cluster=cluster_arn, tasks=task_arns)
            for task in tasks_details['tasks']:
                
                version = task.get('platformVersion', 'LATEST')
                print(f"{task['taskArn']};{version}")
        else:
            print(f"{cluster_arn};No Fargate tasks running")

if __name__ == "__main__":
    get_fargate_versions()
