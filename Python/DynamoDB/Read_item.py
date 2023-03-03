from botocore.exceptions import ClientError
import boto3  # import Boto3

def get_device(name, key, dynamodb=None):
    dynamodb = boto3.resource('dynamodb')
    # Specify the table to read from
    devices_table = dynamodb.Table('MyTechnic')

    try:
        response = devices_table.get_item(
            Key={'name': name, 'key': key})
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        return response['Item']


if __name__ == '__main__':
    technic = get_device("Lamborghini", "Car",)
    if technic:
        print("Get Technics Data Done:")
        # Print the data read
        print(technic)