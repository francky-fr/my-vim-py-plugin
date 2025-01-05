import boto3
from botocore.exceptions import SSOTokenLoadError 
import urllib
import json
from py.sso import aws_sso_login
import logging

logging.getLogger(__name__)


def get_connection_str(user, password, host, port, db):
    user = urllib.parse.quote_plus(user)
    # password = urllib.parse.quote_plus(password)
    password = urllib.parse.quote(password, safe='')
    return f"postgresql://{user}:{password}@{host}:{port}/{db}"


def get_iam_connection_str(region, host, workgroup, port, db):
    redshift = boto3.client('redshift-serverless', region_name=region)
    creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    return get_connection_str(creds_dict['dbUser'], creds_dict['dbPassword'], host, port, db)


def get_iam_connection_str_from_sm(region, sm_path):
    secret_manager = boto3.client('secretsmanager', region_name=region)
    secret_resp = secret_manager.get_secret_value(SecretId=sm_path)
    creds_dict = json.loads(secret_resp['SecretString'])['default']
    return get_connection_str(creds_dict['USER'], creds_dict['PASSWORD'], creds_dict['HOST'], creds_dict['PORT'], creds_dict['NAME'])

def get_sso_connection_str(profile_name, region, host, workgroup, port, db):
    session = boto3.Session(profile_name=profile_name)
    redshift = session.client('redshift-serverless', region_name=region)
    try:
        creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    except SSOTokenLoadError:
        logging.info('SSO not authent yet, calling aws sso login ...')
        aws_sso_login(profile_name)
        creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    return get_connection_str(creds_dict['dbUser'], creds_dict['dbPassword'], host, port, db)
