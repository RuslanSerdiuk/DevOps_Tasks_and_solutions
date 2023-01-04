import urllib3
import json

http = urllib3.PoolManager()


def lambda_handler(event, context):
    url = "https://hooks.slack.com/services/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"
    msg = {
        "channel": "#alarm-for-the-glue-job",
        "username": "WEBHOOK_USERNAME",
        "text": "Glue-job 'CommService_DynamoDB_to_s3' - " + event["message"]["detail"]["state"],
        "icon_emoji": "",
    }

    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)
    print(
        {
            "message": event["message"]["detail"]["state"],
            "status_code": resp.status,
            "response": resp.data,
        }
    )