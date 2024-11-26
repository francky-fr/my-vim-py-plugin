import boto3



def get_connection_str(user, password, host, port, db):
    return f"postgresql://{user}:{password}@{host}:{port}/{db}"


def get_iam_connection_str(region, host, workgroup, port, db):
    redshift = boto3.client('redshift-serverless', region_name=region)
    creds_dict = redshift.get_credentials(dbName=db, workgroupName=workgroup)
    return get_connection_str(creds_dict['dbUser'], creds_dict['dbPassword'], host, port, db)

