import boto3

boto3.setup_default_session(profile_name="xxxxxxxxx")

def get_all_layers(client):
    paginator = client.get_paginator('list_layers')
    layers = []
    for page in paginator.paginate(PaginationConfig={'PageSize': 50}):
        layers.extend(page['Layers'])
    return layers

def get_all_lambda_functions(client):
    paginator = client.get_paginator('list_functions')
    functions = []
    for page in paginator.paginate(PaginationConfig={'PageSize': 50}):
        functions.extend(page['Functions'])
    return functions

def get_layers_in_use(lambda_client, lambda_functions):
    layers_in_use = set()
    for function in lambda_functions:
        function_name = function['FunctionName']
        configuration = lambda_client.get_function_configuration(FunctionName=function_name)
        if 'Layers' in configuration:
            for layer in configuration['Layers']:
                layers_in_use.add(layer['Arn'])
    return layers_in_use

def delete_unused_layers(lambda_client, layers, layers_in_use):
    for layer in layers:
        layer_name = layer['LayerName']
        versions = lambda_client.list_layer_versions(LayerName=layer_name)['LayerVersions']
        
        for version in versions:
            layer_arn = version['LayerVersionArn']
            if layer_arn not in layers_in_use:
                print(f"Deleting unused layer version: {layer_arn}")
                # lambda_client.delete_layer_version(LayerName=layer_name, VersionNumber=version['Version'])

def main():
    lambda_client = boto3.client('lambda')

    layers = get_all_layers(lambda_client)

    lambda_functions = get_all_lambda_functions(lambda_client)

    layers_in_use = get_layers_in_use(lambda_client, lambda_functions)

    delete_unused_layers(lambda_client, layers, layers_in_use)

if __name__ == "__main__":
    main()
