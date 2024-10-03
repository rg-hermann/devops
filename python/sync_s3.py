import boto3
import botocore

def list_objects(profile_name, bucket_name):
    try:
        session = boto3.Session(profile_name=profile_name)
        s3 = session.client('s3')
    except botocore.exceptions.BotoCoreError as e:
        print(f"Erro ao criar sessão: {e}")
        return set()

    objects = []
    continuation_token = None
    
    try:
        while True:
            if continuation_token:
                print(f"Continuando com token: {continuation_token}")
                response = s3.list_objects_v2(Bucket=bucket_name, ContinuationToken=continuation_token)
            else:
                response = s3.list_objects_v2(Bucket=bucket_name)
            
            
            if 'Contents' in response:
                objects.extend([obj['Key'] for obj in response['Contents']])
            else:
                print(f"Nenhum objeto encontrado no bucket {bucket_name}. Resposta: {response}")

            
            if response.get('IsTruncated'):  
                continuation_token = response.get('NextContinuationToken')
            else:
                break

    except botocore.exceptions.ClientError as e:
        print(f"Erro ao listar objetos do bucket {bucket_name}: {e}")
    
    return set(objects)

def compare_buckets(bucket1, bucket2):
    only_in_bucket1 = bucket1 - bucket2
    only_in_bucket2 = bucket2 - bucket1
    common = bucket1 & bucket2
    
    return only_in_bucket1, only_in_bucket2, common

def copy_objects_between_buckets(source_profile, source_bucket, target_profile, target_bucket, objects):
    source_session = boto3.Session(profile_name=source_profile)
    target_session = boto3.Session(profile_name=target_profile)

    s3_source = source_session.client('s3')
    s3_target = target_session.client('s3')

    for obj in objects:
        copy_source = {
            'Bucket': source_bucket,
            'Key': obj
        }

        try:
            s3_target.copy_object(CopySource=copy_source, Bucket=target_bucket, Key=obj)
            print(f'Copiado {obj} de {source_bucket} para {target_bucket}')
        except botocore.exceptions.ClientError as e:
            print(f"Falha ao copiar {obj}: {e}")


bucket_name_prd = 'xxxxxxx'
bucket_name_stg = 'xxxxxxx'
profile_prd = 'xxxxxxxx'
profile_stg = 'xxxxxxxx'


objects_prd = list_objects(profile_prd, bucket_name_prd)
objects_stg = list_objects(profile_stg, bucket_name_stg)


only_in_prd, only_in_stg, common_objects = compare_buckets(objects_prd, objects_stg)


copy_objects_between_buckets(profile_prd, bucket_name_prd, profile_stg, bucket_name_stg, only_in_prd)
