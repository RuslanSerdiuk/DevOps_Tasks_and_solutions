#!/bin/bash


DATABASE=moodle

ROW_FORMAT=DYNAMIC

TABLES=$(echo SHOW TABLES | mysql -s $DATABASE)

for TABLE in $TABLES ; do
    echo "ALTER TABLE $TABLE ROW_FORMAT=$ROW_FORMAT;"
    echo "ALTER TABLE $TABLE ROW_FORMAT=$ROW_FORMAT" | mysql moodle
done
