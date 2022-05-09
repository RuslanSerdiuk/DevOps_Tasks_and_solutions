# Task-05b-10:
# Найти N периодов времени dT (1 мин, 2 мин, 3 мин и т.д.) за который было выполнено самое
# большое количество запросов

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