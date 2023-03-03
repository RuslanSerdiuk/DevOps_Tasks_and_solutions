# Create, adding items, scanning, delete DynamoDB Table using Python

## TASK:
### The objectives:
- Create a DynamoDB table using Python
- Add items to the table
- Scan the DynamoDB table
- Delete the DynamoDB table
- Delete items (options)

### Table: Components
- indexes: 
  - ID, name, status, key

### For this task we need:
- AWS cli 
- boto3 `pip install boto3`
- Click `pip install click`


#### 1. Create a DynamoDB table (indexes: ID, name, status, key):

`python .\Create_table.py <your_table_name>`

```    
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
```


#### 2. Loading data to the DynamoDB from [json file](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/DynamoDB/data_table.json):

`python .\Load_data.py <name_your_table> --jsonfile <Path_and_name_your_json_file>`
```
import decimal
import boto3
import json
import click


@click.command()
@click.argument("name_table")
@click.option("--region", "-r", default="us-east-2", help="your AWS region")
@click.option("--jsonfile", "-f", default="data_table.json", help="Path and name your .json file | Default = data_table.json")

def load_data(name_table, region, jsonfile):
    dynamodb = boto3.resource('dynamodb', region_name=region)

    table = dynamodb.Table(name_table)

    with open(jsonfile) as json_file:
        technic_data = json.load(json_file, parse_float=decimal.Decimal)
        for technic in technic_data:
            uuid   = technic['uuid']
            name   = technic['name']
            status = technic['status']
            key    = technic['key']
            Parameters = technic['Parameters']

            print("Adding technics:", uuid, name, status, key, Parameters)

            table.put_item(
            Item={
                'uuid': uuid,
                'name': name,
                'status': status,
                "key": key,
                "Parameters": Parameters
            }
            )


if __name__ == "__main__":
    data = load_data()
```


#### 3. Add items to the table
I have implemented a solution, adding an item from a [json file](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/DynamoDB/item.json)!

`python .\Add_item.py <name_your_table> --jsonfile <Path_and_name_your_json_file_with_item>`
```
import json
import boto3
import click


@click.command()
@click.argument("name_table")
@click.option("--jsonfile", "-f", default="item.json", help="Path and name your .json file | Default = data_table.json")

def add_item(name_table, jsonfile):
	dynamodb = boto3.resource('dynamodb')

	table = dynamodb.Table(name_table)
	with open(jsonfile, "r") as fcc_file:
		fcc_data = json.load(fcc_file)
	response = table.put_item(
	Item = fcc_data
	)
	print(response)


if __name__ == "__main__":
    item = add_item()
```


#### 4. Update item in the DynamoDB table: 

`python .\Update_item.py`
```
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
```


#### 5. Scan the DynamoDB table
This solution is implemented only for illustration of the work!
```
import boto3
import click

def scan_items(name_table):
    dynamodb = boto3.resource('dynamodb')

    table = dynamodb.Table(name_table)

    response = table.scan()
    response['Items']

    return print(response)

def list_tables():
    dynamodb = boto3.resource('dynamodb')
    return print(list(dynamodb.tables.all()))


@click.command()
@click.argument("name_table")
@click.option("-s", "--show")

def cli(name_table, show):
    if show in locals():
        print("ALL TABLES EXIST: ")
        list_tables()
    else:
        print("===== SCAN RESULT: =====")
        scan_items(name_table)


if __name__ == "__main__":
    cli()
```
also we can get only list all DynamoDB tables:

`python .\List_tables.py`
```
import boto3

dynamodb = boto3.resource('dynamodb')
print(list(dynamodb.tables.all()))
```


#### 6. Read item in the DynamoDB table: 

`python .\Read_item.py`
```
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
```


#### 7. Delete the DynamoDB table: 

`python .\Delete_table.py <name_your_table>`
```
import boto3
import click

@click.command()
@click.argument("name_table")
@click.option("--region", "-r", default="us-east-2", help="your AWS region")
def delete_table(name_table, region):
    dynamodb = boto3.resource('dynamodb', region_name=region)

    table = dynamodb.Table(name_table)
    table.delete()

if __name__ == "__main__":
    delete_table()
```


### 8. Delete items (options): 

`python .\Delete_item.py`
```
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
```


## _LINKS:_
+ _https://www.tutorialspoint.com/dynamodb/dynamodb_quick_guide.htm_
+ _https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html_
+ _https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html_
+ _https://opensource.adobe.com/Spry/samples/data_region/JSONDataSetSample.html_
+ _https://amazon-dynamodb-labs.workshop.aws/game-player-data/core-usage/step2.html_


+ _https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GettingStarted.CreateTable.html_
+ _https://catalog.us-east-1.prod.workshops.aws/workshops/3d705026-9edc-40e8-b353-bdabb116c89c/en-US/persisting-data/dynamodb/step-3_
