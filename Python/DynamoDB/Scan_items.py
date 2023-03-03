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