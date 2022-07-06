# Task-4-3:
# Найти N самых частых User-Agent

import re
from collections import Counter


def reader(filename):
    regexp = r'(\"\w+/\d.\d \(\w+. \w+ .*)\"\w+://\d+.\d+.\d+.\d+:\d+\"'

    with open(filename) as f:
        log = f.read()
        user_agents = re.findall(regexp, log)
    return user_agents


def count(user_agents):
    number = input('How many of the most common "User-agents" are you want to print? ')
    number = int(number) + 1
    count = Counter(user_agents).most_common(number)
    x = 0
    for i in range(number):
        x = x + 1
        print(str(count[i][1]) + " - times User-agent by name is: " + str(count[i][0]))
        if x == number - 1:
            break
if __name__ == '__main__':
    count(reader(r'access_log'))