from email.policy import default
import boto3
import click


@click.command()
@click.argument("name_table")
@click.option("--region", "-r", default="us-east-2", help="your AWS region")

def create_table(name_table, region):
    dynamodb = boto3.resource('dynamodb', region_name=region)

    table = dynamodb.create_table(
        TableName=name_table,
        KeySchema=[
            {
                'AttributeName': 'name',
                'KeyType': 'HASH'  #Partition key
            },
            {
                'AttributeName': 'key',
                'KeyType': 'RANGE'  #Sort key
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'name',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'key',
                'AttributeType': 'S'
            },

        ],
        GlobalSecondaryIndexes=[
            {
                'IndexName': 'uuid',
                'KeySchema': [
                    {'AttributeName': 'name','KeyType': 'HASH'},
                    {'AttributeName': "key", 'KeyType': "RANGE"},
                ],
                'Projection': {
                    'ProjectionType': 'ALL'
                },
                'ProvisionedThroughput': {
                    'ReadCapacityUnits': 1,
                    'WriteCapacityUnits': 1
                }
            },
            {
                'IndexName': 'name',
                'KeySchema': [
                    {'AttributeName': 'name','KeyType': 'HASH'},
                    {'AttributeName': "key", 'KeyType': "RANGE"},
                ],
                'Projection': {
                    'ProjectionType': 'ALL'
                },
                'ProvisionedThroughput': {
                    'ReadCapacityUnits': 1,
                    'WriteCapacityUnits': 1
                }
            },
            {
                'IndexName': 'status',
                'KeySchema': [
                    {'AttributeName': 'name','KeyType': 'HASH'},
                    {'AttributeName': "key", 'KeyType': "RANGE"},
                ],
                'Projection': {
                    'ProjectionType': 'ALL'
                },
                'ProvisionedThroughput': {
                    'ReadCapacityUnits': 1,
                    'WriteCapacityUnits': 1
                }
            },
            {
                'IndexName': 'key',
                'KeySchema': [
                    {'AttributeName': 'name','KeyType': 'HASH'},
                    {'AttributeName': "key", 'KeyType': "RANGE"},
                ],
                'Projection': {
                    'ProjectionType': 'ALL'
                },
                'ProvisionedThroughput': {
                    'ReadCapacityUnits': 1,
                    'WriteCapacityUnits': 1
                }
            },
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 10,
            'WriteCapacityUnits': 10
        }
    )

    print("Table status:", table.table_status)

    print("Warning for", table.name, "to complete creating...")
    table.meta.client.get_waiter("table_exists").wait(TableName="MyTechnic")
    print("Table status:", dynamodb.Table("MyTechnic").table_status)


if __name__ == "__main__":
    table = create_table()