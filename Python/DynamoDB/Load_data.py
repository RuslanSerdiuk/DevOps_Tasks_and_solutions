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