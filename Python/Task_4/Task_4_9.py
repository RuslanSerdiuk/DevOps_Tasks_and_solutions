# Task-4-9:
# К-во запросов по апстримам (воркерам) в dT (30 сек, 1 минуту, 5 мин)
# По лог файлу должно находить за 30 сек - 3249 запросов; за 60 сек - 6268 запросов; за 300 сек - 31226 запросов.

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
    our_file = input(r"Please enter path your file (for example C:\Users\Ruslan_Serdiuk\your path\access_log): ")
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