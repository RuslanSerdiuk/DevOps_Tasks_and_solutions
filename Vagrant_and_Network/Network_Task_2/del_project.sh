#!/bin/bash

curl --request DELETE --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/134402" | ./jq-win64.exe '.'