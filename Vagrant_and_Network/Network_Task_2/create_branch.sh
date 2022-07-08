#!/bin/bash

curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/repository/branches?branch=issue&ref=master" | ./jq-win64.exe '.'