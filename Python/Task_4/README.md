# Python: Parsing access.log

## TASK:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Task_4.png)

> **Here only code of the solution.**    
> **The tasks and screenshots located in the .py files and folder "Screensots"**
>
> **The present several variations of read access log. You can enter your path to log_file or put log_file in folder with script file.py and the program found it herself**


#### In first of all I searched information about Apache access.log and how right read it. Every tasks of task-05b consists of three steps:
1. Extract necessary information from the access.log file using Regular Expression
2. Filtering the received information in the array by user criteria
3. Write filtered information to an array or print on the display


#### Task-4-1:
```
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
```
Screenshot work program:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-1.png)
___

#### Task-4-2:
```
import re
from datetime import datetime, timedelta


def main(start_time, time_period, log_file):
    begin_time = datetime.strptime(start_time, "%d/%b/%Y:%H:%M:%S")
    time_delta = timedelta(seconds=time_period)
    end_time = begin_time + time_delta
    with open(log_file) as data:
        count = 0
        for str_line in data:
            pattern = r'\d+/\w+/\d+:\d+:\d+:\d+'
            time = re.findall(pattern, str_line)
            line_time = datetime.strptime(time[0], "%d/%b/%Y:%H:%M:%S")
            if begin_time <= line_time <= end_time:
                count += 1
    return count


if __name__ == '__main__':
    our_file = input(r"Please enter path your file (for example C:\Users\Ruslan_Serdiuk\your path\access_log): ")
    start_time = input("Please enter date and time in format:'08/Oct/2015:09:01:41' - ")
    time_period = int(input("Please enter the period in sec - "))
    number = main(start_time, time_period, our_file)
    print("Searched = " + str(number))
```
Screenshot work program:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-2.png)
___

#### Task-4-3:
```
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
```
Screenshot work program:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-3.png)
___
#### Task-4-4:
```
import re
from datetime import datetime, timedelta


def main(start_time, time_period, log_file):
    begin_time = datetime.strptime(start_time, "%d/%b/%Y:%H:%M:%S")
    time_delta = timedelta(seconds=time_period)
    end_time = begin_time + time_delta
    with open(log_file) as data:
        count = 0
        for str_line in data:
            if 'HTTP/1.1" 500' in str_line:
                pattern = r'\d+/\w+/\d+:\d+:\d+:\d+'
                time = re.findall(pattern, str_line)
                line_time = datetime.strptime(time[0], "%d/%b/%Y:%H:%M:%S")
                if begin_time <= line_time <= end_time:
                    count += 1
    return count


if __name__ == '__main__':
    our_file = input(r"Please enter path your file (for example C:\Users\Ruslan_Serdiuk\your path\access_log): ")
    start_time = input("Please enter date and time in format:'08/Oct/2015:09:01:41' - ")
    time_period = int(input("Please enter the period in sec - "))
    number = main(start_time, time_period, our_file)
    print("Searched = " + str(number))
```
Screenshot work program
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-4.png)
___

#### Task-4-5:
```
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
```
Screenshot work program:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-5.png)
___

#### Task-4-6:
```
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
```
Screenshot work program:
![](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Python/Python/Task_4/Screenshots/Task-4-6.png)
___

#### Task-05b-7:
```
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
```
[Link on the screenshot work program](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m2-Python-Task-05b/Module-02_Python/Task-05b/Screenshots/Task-05b-7.png)
___

#### Task-05b-8:
```
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
```
[Link on the screenshot work program](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m2-Python-Task-05b/Module-02_Python/Task-05b/Screenshots/Task-05b-8.png)
___

#### Task-05b-9:
```
import re
from datetime import datetime, timedelta


def main(start_time, time_period, log_file):
    begin_time = datetime.strptime(start_time, "%d/%b/%Y:%H:%M:%S")
    time_delta = timedelta(seconds=time_period)
    end_time = begin_time + time_delta
    with open(log_file) as data:
        count = 0
        for str_line in data:
            pattern1 = r'[a-z]+://\d+.\d+.\d+.\d+:\d+'
            upstream = re.findall(pattern1, str_line)
            str_upstream = ''.join(upstream)
            if str_upstream in str_line:
                pattern = r'\d+/\w+/\d+:\d+:\d+:\d+'
                time = re.findall(pattern, str_line)
                line_time = datetime.strptime(time[0], "%d/%b/%Y:%H:%M:%S")
                if begin_time <= line_time <= end_time:
                    count += 1
    return count


if __name__ == '__main__':
    our_file = input(r"Please enter path your file (for example C:\Users\Ruslan_Serdiuk\Desktop\Task-05b\access_log): ")
    start_time = input("Please enter date and time in format:'08/Oct/2015:09:01:41' - ")
    time_period = 0
    count = 0
    for x in range(3):
        count = count + 1
        if count == 1:
            time_period = 30
        elif count == 2:
            time_period = 60
        elif count == 3:
            time_period = 300
        number = main(start_time, time_period, our_file)
        print("In " + str(time_period) + " sec searched = " + str(number))
```
[Link on the screenshot work program](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m2-Python-Task-05b/Module-02_Python/Task-05b/Screenshots/Task-05b-9.png)
___

#### Task-05b-10:
```
import re
from datetime import datetime, timedelta


def main(start_time, time_period, log_file):
    begin_time = datetime.strptime(start_time, "%d/%b/%Y:%H:%M:%S")
    time_delta = timedelta(seconds=time_period)
    end_time = begin_time + time_delta
    with open(log_file) as data:
        count = 0
        for str_line in data:
            pattern = r'\d+/\w+/\d+:\d+:\d+:\d+'
            time = re.findall(pattern, str_line)
            line_time = datetime.strptime(time[0], "%d/%b/%Y:%H:%M:%S")
            if begin_time <= line_time <= end_time:
                count += 1
    return count


if __name__ == '__main__':
    our_file = r"access_log"
    start_time = '08/Oct/2015:09:01:41'
    minute = input("Please enter the minutes: ")
    time_period = 0
    for x in range(int(minute)):
        time_period = time_period + 60
        number = main(start_time, time_period, our_file)
        print("In " + str(time_period) + " sec searched = " + str(number))
```
[Link on the screenshot work program](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m2-Python-Task-05b/Module-02_Python/Task-05b/Screenshots/Task-05b-10.png)
___
_**Additional sources of information were used:**_
- [ ] https://www.sentinelone.com/blog/detailed-introduction-apache-access-log/
- [ ] https://linuxhint.com/review-apache-tomcat-access-logs/
