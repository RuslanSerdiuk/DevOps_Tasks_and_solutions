import re
from collections import Counter
# \(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}

def reader(filename):
    regexp = r'\(\d+.\d+.\d+.\d+|, \d+.\d+.\d+.\d+'

    with open(filename) as f:
        log = f.read()
        ip_list = re.findall(regexp, log)
        str = ''.join(ip_list)
        str = str.replace(',', '').replace('(', ' ')
        ip_list = str.split(' ')
    return ip_list


def count(ip_list):
    number = input('How many of the most common IP-Addresses are you want to print? ')
    number = int(number)
    count = Counter(ip_list).most_common(number)
    print("\nThe most common IP:")
    for i in range(number):
        print(str(count[i][0]) + " = " + str(count[i][1]) + " times")
        if i == number - 1:
            break


if __name__ == '__main__':
    count(reader(r'access_log'))