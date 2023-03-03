from pprint import pprint  # import pprint, a module that enable to “pretty-print”
import boto3  # import Boto3
import click

def update_technic(name_table, name, key, status, dynamodb=None):
    dynamodb = boto3.resource('dynamodb')
    # Specify the table
    devices_table = dynamodb.Table(name_table)

    response = devices_table.update_item(
        Key={
            'name': name,
            'key': key
        },
        UpdateExpression="set staus = :s",
        ExpressionAttributeValues={
            ':s': status
        },
        ReturnValues="UPDATED_NEW"
    )
    return response

@click.command()
@click.argument("name_table")
@click.option("--name", "-n", default="Lamborghini", help="Name your element in table")
@click.option("--key", "-k", default="Car", help="Key your element in table")
@click.option("--status", "-s", default="Broken", help="Enter the new status of your element in table")

def main(name_table, name, key, status):
    update_response = update_technic(name_table, name, key, status)
    print("Device Updated")
    # Print response
    pprint(update_response)

if __name__ == "__main__":
    main()