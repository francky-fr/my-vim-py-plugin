import subprocess

def aws_sso_login(profile_name):
    subprocess.run(
            ["aws", "sso", "login", "--profile", profile_name],
            check=True,
            )
