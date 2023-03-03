from botocore.exceptions import ClientError
from pprint import pprint  # import pprint, a module that enable to “pretty-print”
import boto3  # import Boto3


def delete_technic(name, key, status, dynamodb=None):
    dynamodb = boto3.resource('dynamodb')
    # Specify the table to delete from
    devices_table = dynamodb.Table('MyTechnic')

    try:
        response = devices_table.delete_item(
            Key={
                'name': name,
                'key': key
            },
            # Conditional request
            ConditionExpression="#status_1 = :Broken",
            ExpressionAttributeNames= {
            "#status_1": "status"
            },
            ExpressionAttributeValues={
                ":Broken": status
            }
        )
    except ClientError as er:
        if er.response['Error']['Code'] == "ConditionalCheckFailedException":
            print(er.response['Error']['Message'])
        else:
            raise
    else:
        return response


if __name__ == '__main__':
    print("DynamoBD Conditional delete")
    # Provide name, key, status
    delete_response = delete_technic("AUDI", "Car", "Broken")
    if delete_response:
        print("Item Deleted:")
        # Print response
        pprint(delete_response)