#!/bin/bash

curl --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/users?search=andrii_kurapov@epam.com" | ./jq-win64.exe '.'