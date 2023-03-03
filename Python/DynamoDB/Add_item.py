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