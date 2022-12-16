# Task-4-8:
# По рефереру найти статистику переходов. В результате указать домены и к-во переходов, указать
#                                                                                       сортировку (домен или кол-во)
# &[e-r]+=\w+%\d\w%\d\w%\d\w+.\w+.\w+.\w+
# [w]{3}.\w+.\w+.\w+

import re
from collections import Counter


def reader(filename):
    regexp = r'&[e-r]+=\w+%\d\w%\d\w%\d\w+.\w+.\w+.\w+'

    with open(filename) as f:
        log = f.read()
        refer_list = re.findall(regexp, log)
        refer_list = ''.join(refer_list)
        domen_regex = r'[w]{3}..\w+.\w+.\w+'
        my_domains = re.findall(domen_regex, refer_list)
    return my_domains


def count(my_domains, requests):
    return Counter(my_domains).most_common(requests)


if __name__ == '__main__':
    req = int(input("Please enter, how many referers domains are you see? "))
    count = count(reader(r'access_log'), requests=req)
    for i in count:
        if i == 3:
            break
        print(" The domain: " + i[0] + " found = " + str(i[1]) + " time")
    if req > len(count):
        print("\t\tSORRY!\n\t\tThese all referer domains that have access_log file(")