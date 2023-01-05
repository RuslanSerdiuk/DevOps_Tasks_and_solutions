import urllib3
import json

http = urllib3.PoolManager()
url = "https://hooks.slack.com/services/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"

def get_alarm_attributes(sns_message):
    alarm = dict()

    alarm['detail-type'] = sns_message['detail-type']
    alarm['jobName'] = sns_message['detail']['jobName']
    alarm['jobRunId'] = sns_message['detail']['jobRunId']
    alarm['state'] = sns_message['detail']['message']
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


def lambda_handler(event, context):

    sns_message = event["Records"][0]["Sns"]["Message"]
    alarm = get_alarm_attributes(sns_message)

    msg = str()

    if alarm['detail-type'] == "Glue Job State Change":
        msg = success_alarm(alarm)
        
    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)
    print(
        {
            "message": msg,
            "status_code": resp.status,
            "response": resp.data,
        }
    )