import boto3
import urllib

def escape_special_chars(text):
    # return re.sub(r'([^\w\s])', r'\\\1', text)
    # return re.escape(r'([^\w\s])', r'\\\1', text)
    return re.sub(r'(:)', r'\\\1', text)

def get_connection_str(user, password, host, port, db):
    user = urllib.parse.quote_plus(user)
    password = urllib.parse.quote_plus(password)
    return f"postgresql://{user}:{password}@{host}:{port}/{db}"


def get_iam_connection_str(region, host, workgroup, port, db):
    redshift = boto3.client('redshift-serverless', region_name=region)
    creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    return get_connection_str(creds_dict['dbUser'], creds_dict['dbPassword'], host, port, db)

