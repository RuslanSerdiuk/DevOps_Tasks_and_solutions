#!/bin/bash

# 1-st arg - Type of resource to create
# 2-nd arg - Name of resource
# For example: bash get_id.sh projects new_project

curl -s --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/search?scope=$1&search=$2" | jq '.[].id' 2> /dev/null