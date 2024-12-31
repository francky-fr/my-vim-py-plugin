import boto3
import urllib
import json


def get_connection_str(user, password, host, port, db):
    user = urllib.parse.quote_plus(user)
    password = urllib.parse.quote_plus(password)
    return f"postgresql://{user}:{password}@{host}:{port}/{db}"


def get_iam_connection_str(region, host, workgroup, port, db):
    redshift = boto3.client('redshift-serverless', region_name=region)
    creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    return get_connection_str(creds_dict['dbUser'], creds_dict['dbPassword'], host, port, db)


def get_iam_connection_str_from_sm(region, sm_path):
    secret_manager = boto3.client('secretsmanager', region_name=region)
    secret_resp = secret_manager.get_secret_value(SecretId=sm_path)
    creds_dict = json.loads(secret_resp['SecretString'])['default']
    print(creds_dict)
    return get_connection_str(creds_dict['USER'], creds_dict['PASSWORD'], creds_dict['HOST'], creds_dict['PORT'], creds_dict['NAME'])
