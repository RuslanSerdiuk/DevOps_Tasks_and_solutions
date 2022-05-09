# Task-05b-7:
# К-во запросов по апстримам (воркерам)

import re
from collections import Counter


def reader(filename):
    regexp = r'[a-z]+://\d+.\d+.\d+.\d+:\d+'

    with open(filename) as f:
        log = f.read()
        work_list = re.findall(regexp, log)
    return work_list


def count(work_list, requests):
    count = Counter(work_list).most_common(requests)
    return count


if __name__ == '__main__':
    req = int(input("Please enter, how many the most common Workers are you see? "))
    count = count(reader(r'access_log'), requests=req)
    for i in count:
        print("The worker: " + i[0] + " found = " + str(i[1]) + '')
