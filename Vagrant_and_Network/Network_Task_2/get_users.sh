#!/bin/bash

curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/users" | ./jq-win64.exe '.'
