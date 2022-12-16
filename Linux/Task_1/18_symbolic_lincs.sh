#!/bin/bash
source=/home/user/Documents
target=/home/user/Study
path_to_file=$PWD



filename='18_test_file'
n=1
while read line; do
# reading each line
path_to_link+=$line | cut -d " " -f -1
name+=$line | cut -d " " -f 1
name+=$path_to_file
echo $line | cut -d " " -f -1
echo $name
echo $path_to_link
echo $line
done < $filename
