import urllib3
import json
import boto3
from botocore.exceptions import ClientError

secret_name = "s3-to-snowflake-credentials-migration-pd"
region_name = "us-east-2"

session = boto3.session.Session()
client = session.client(
    service_name='secretsmanager',
    region_name=region_name
)

get_secret_value_response = client.get_secret_value(
    SecretId=secret_name
)

secret = json.loads(get_secret_value_response['SecretString'])

http = urllib3.PoolManager()
url = secret['SLACK_URL']

def get_alarm_attributes(sns_message):
    alarm = dict()

    alarm['detail-type'] = sns_message['detail-type']
    alarm['jobName'] = sns_message['detail']['jobName']
    alarm['jobRunId'] = sns_message['detail']['jobRunId']
    alarm['state'] = sns_message['detail']['message']
    alarm['state2'] = sns_message['detail']['state']
    alarm['time'] = sns_message['time']
    alarm['region'] = sns_message['region']

    return alarm

def success_alarm(alarm):
    return {
        "type": "home",
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": ":large_green_circle: " + alarm['detail-type']
                }
            },
            {
                "type": "divider"
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*GlueJobName:* " + '\n' + alarm['jobName'] + '\n' + '\n' + "*jobRunId:*" + " " + alarm['jobRunId'] + '\n' + '\n' + "*State Job:*" + " " + alarm['state'] + " :white_check_mark:"
                },
                "block_id": "text1"
            },
            {
                "type": "divider"
            },
            {
                "type": "context",
                "elements": [
                    {
                        "type": "mrkdwn",
                        "text": "*Time:*" + " " + alarm['time'] + '\n' + '\n' + "Region: *" + alarm['region'] + "*"
                    }
                ]
            }
        ]
    }

def failure_alarm(alarm):
    return {
        "type": "home",
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": ":red_circle: " + alarm['detail-type']
                }
            },
            {
                "type": "divider"
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*GlueJobName:* " + '\n' + alarm['jobName'] + '\n' + '\n' + "*jobRunId:*" + " " + alarm['jobRunId'] + '\n' + '\n' + "*State Job:*" + " " + alarm['state'] + " :bangbang:"
                },
                "block_id": "text1"
            },
            {
                "type": "divider"
            },
            {
                "type": "context",
                "elements": [
                    {
                        "type": "mrkdwn",
                        "text": "*Time:*" + " " + alarm['time'] + '\n' + '\n' + "Region: *" + alarm['region'] + "*"
                    }
                ]
            }
        ]
    }
    

def lambda_handler(event, context):

    sns_message = json.loads(event["Records"][0]["Sns"]["Message"])
    alarm = get_alarm_attributes(sns_message)

    msg = str()

    if alarm['state2'] == "SUCCEEDED":
        msg = success_alarm(alarm)
    elif alarm['state2'] == 'FAILED':
        msg = failure_alarm(alarm)
    elif alarm['state2'] == 'TIMEOUT':
        msg = failure_alarm(alarm)
    elif alarm['state2'] == 'STOPPED':
        msg = failure_alarm(alarm)
        
    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)
    print(
        {
            "message": msg,
            "status_code": resp.status,
            "response": resp.data,
        }
    )