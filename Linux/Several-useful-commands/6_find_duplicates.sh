#!/bin/bash
source=/home/user/Documents
target=/home/user/Study


for i in "$source"/*
do
 f1=`stat -c%s $i`
 f2=`stat -c%s $target/${i##*/}`
 if f2 -f "$FILE"; then
    if [ "$f1" = "$f2" ]; then
          echo "$i" "$f1" and "$target/${i##*/}" "$f2" "----------" "EQUAL"
    else
          echo "$i" "$f1" and "$target/${i##*/}" "$f2" "----------" "NOT EQUAL"
    fi
  fi
done
