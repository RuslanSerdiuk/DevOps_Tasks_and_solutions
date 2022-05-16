#!/bin/bash

curl --request POST --header "PRIVATE-TOKEN: $API_KEY" "https://git.epam.com/api/v4/projects/119684/merge_requests?source_branch=issue&target_branch=master&title=testMR&remove_source_branch=false" | ./jq-win64.exe '.'
