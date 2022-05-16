#!/bin/bash

curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/122669/merge_requests?source_branch=issue&target_branch=master&title=testMR&remove_source_branch=true" | ./jq-win64.exe '.'