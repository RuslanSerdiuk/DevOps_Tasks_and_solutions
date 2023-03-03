import csv
import re
import json
from collections import defaultdict


xsv_filename = 'list.csv'


def read_file_without_csv_module(filename, delimiter):
    """
    :param filename:
    :param delimiter:
    :return: xsv table
    """
    with open(filename, 'r') as file:
        table = []
        for line in file:
            values = line.split(delimiter)
            table.append(values)
    return table


def read_file(filename, delimiter):
    """
    :param filename:
    :param delimiter:
    :return: xsv table
    """
    with open(filename, 'r') as csv_file:
        table = list(csv.reader(csv_file, delimiter=delimiter))
    return table


def has_header(table):
    """
    :param table:
    :return: has header row or not
    """
    if table[0]:
        return True
    else:
        return False


def csv_filter(table, filter_value):
    """
    :param table:
    :param filter_value:
    :return: If value in row, take this row
    """
    filtered = filter(lambda table: filter_value in table[1], table)
    return list(filtered)


def csv_filter_re(table, pattern):
    """
    :param table:
    :param pattern:
    :return: all matches with re
    """
    result = []
    for row in table:
        for value in row:
            match = re.search(pattern, value)
            if match:
                result.append(value)
    return result


def take_rows(table, first_row_index, last_row_index):
    """
    :param table:
    :param first_row_index:
    :param last_row_index:
    :return: selected rows
    """
    last_row_index += 1
    rows = []
    for i in range(first_row_index, last_row_index):
        rows.append(table[i])
    return rows


def take_columns(table, first_column_index, last_column_index):
    """
    :param table:
    :param first_column_index:
    :param last_column_index:
    :return: selected columns
    """
    last_column_index += 1
    columns = defaultdict(list)
    result = []
    for row in table:
        for i, v in enumerate(row):
            columns[i].append(v)
    for i in range(first_column_index, last_column_index):
        result.append(columns[i])
    return result


def take_field(table, column_index, row_index):
    """
    :param table:
    :param column_index:
    :param row_index:
    :return: selected field
    """
    return table[row_index][column_index]


def csv_to_json(filename, delimiter):
    """
    :param filename:
    :param delimiter:
    """
    # Template for a json file
    data_dict = {'Network_data': []}
    # Read csv file and add each row  into a dict
    with open(filename, newline='') as csv_file:
        csv_dict_reader = csv.DictReader(csv_file, delimiter=delimiter)
        for row in csv_dict_reader:
            data_dict['Network_data'].append(row)
    # Write data_dict to json file
    with open("data_file.json", "w") as json_file:
        json.dump(data_dict, json_file)


def main():
    delimiter = ''
    if xsv_filename.split('.')[-1] == 'csv':
        delimiter = ','
    elif xsv_filename.split('.')[-1] == 'tsv':
        delimiter = '\t'
    elif xsv_filename.split('.')[-1] == 'dsv':
        delimiter = '}'

    table = read_file_without_csv_module(xsv_filename, delimiter)
    print(table)

if __name__ == '__main__':
    main()
