import boto3

boto3.setup_default_session(profile_name="xxxxxxxxxx")

def get_all_lambda_functions(client):
    paginator = client.get_paginator('list_functions')
    functions = []
    for page in paginator.paginate(PaginationConfig={'PageSize': 50}):
        functions.extend(page['Functions'])
    return functions

def get_lambda_function_code_size(client, function_name):
    response = client.get_function(FunctionName=function_name)
    return response['Configuration']['CodeSize']

def get_largest_lambda_functions():
    client = boto3.client('lambda')

    lambda_functions = get_all_lambda_functions(client)

    function_sizes = []
    for function in lambda_functions:
        function_name = function['FunctionName']
        code_size = get_lambda_function_code_size(client, function_name)
        function_sizes.append((function_name, code_size))

    function_sizes.sort(key=lambda x: x[1], reverse=True)

    for function_name, code_size in function_sizes:
        print(f"Function Name: {function_name}, Code Size: {code_size / (1024 * 1024):.2f} MB")

if __name__ == "__main__":
    get_largest_lambda_functions()
