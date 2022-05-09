# Task-05b-5:
# Найти N самых частых запросов или самых коротких запросов

import re

def reader(filename, requests):
    regexp = r'(?:\"\s\d{3}\s)(\d+)'
    with open(filename) as f:
        log = f.read()
        request_list = re.findall(regexp, log)
        request_list.sort()
        from itertools import groupby
        clear_list = [el for el, _ in groupby(request_list)]
        top_clear_list = sorted(range(len(clear_list)), key=lambda x: clear_list[x], reverse=True)[:requests]
        myTop = "".join(str(x) + "\n" for x in top_clear_list)
    return myTop


if __name__ == '__main__':
    req = int(input("Please enter how many requests are you want see?: "))
    top_clear_list = reader(r'access_log', requests=req)
    print("The most popular " + str(req) + " requests:\n" + str(top_clear_list))