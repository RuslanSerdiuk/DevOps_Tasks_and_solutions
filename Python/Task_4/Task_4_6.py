# Task-4-6:
# N самых частых запросов до K-го слеша, т.е. 2-го слеша
# если запрос "GET /merlin-service-search/rest/vehiclefamilyvalueslookup/117341 HTTP/1.1",
# то статистику собирать по /merlin-service-search

import re
from collections import Counter


def reader(filename):
    regexp = r'[A-Z]{3} /\w+[^)/]+'

    with open(filename) as f:
        log = f.read()
        request_list = re.findall(regexp, log)
    return request_list


def count(request_list):
    number = input('How many of most common requests are you want to print? ')
    number = int(number) + 1
    count = Counter(request_list).most_common(number)
    x = 0
    count_req = ''
    for i in range(number):
        x = x + 1
        count_req = count_req + str(count[i][1]) + " - times request by name is: " + str(count[i][0] + "\n")
#        print(str(count[i][1]) + " - times request by name is: " + str(count[i][0]))
        if x == number - 1:
            break
    return count_req


if __name__ == '__main__':
    top = count(reader(r'access_log'))
    print(top)
