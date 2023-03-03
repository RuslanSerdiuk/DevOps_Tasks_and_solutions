from email.policy import default
from botocore.exceptions import ClientError
import boto3  # import Boto3
import click

def get_device(name_table, name, key, dynamodb=None):
    dynamodb = boto3.resource('dynamodb')
    # Specify the table to read from
    devices_table = dynamodb.Table(name_table)

    try:
        response = devices_table.get_item(
            Key={'name': name, 'key': key})
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        return response['Item']


@click.command()
@click.argument("name_table")
@click.option("--name", "-n", default="Lamborghini", help="Name your element in table")
@click.option("--key", "-k", default="Car", help="Key your element in table")

def main(name_table, name, key):
    technic = get_device(name_table, name, key,)
    if technic:
        print("Get Technics Data Done:")
        # Print the data read
        print(technic)

if __name__ == "__main__":
    main()