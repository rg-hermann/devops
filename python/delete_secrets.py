import boto3

boto3.setup_default_session(profile_name="xxxxxxxxxx")
client = boto3.client('secretsmanager')

response = client.list_secrets(IncludePlannedDeletion=True,MaxResults=100)
print(response['SecretList'])

for secret in response['SecretList']:
    secret_name = secret['Name']
    try:
        client.delete_secret(
            SecretId=secret_name,
            ForceDeleteWithoutRecovery=True
        )
        print(f'Secret {secret_name} deleted successfully.')
    except Exception as e:
        print(f'Failed to delete secret {secret_name}: {e}')
