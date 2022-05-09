# Task-05b-2:
# Найти частоту запросов в интервал времени dT (минут)

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
    our_file = input(r"Please enter path your file (for example C:\Users\Ruslan_Serdiuk\Desktop\Task-05b\access_log): ")
    start_time = input("Please enter date and time in format:'08/Oct/2015:09:01:41' - ")
    time_period = int(input("Please enter the period in sec - "))
    number = main(start_time, time_period, our_file)
    print("Searched = " + str(number))