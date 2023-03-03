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