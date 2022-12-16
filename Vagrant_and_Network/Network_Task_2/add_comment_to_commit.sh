#!/bin/bash

curl --request POST --header "PRIVATE-TOKEN: $API_KEY" \
     --form "note=My Test Comment\!" --form "path=master/README.md" --form "line=19" --form "line_type=new" \
     "https://git.epam.com/api/v4/projects/119684/repository/commits/b7b13d9f9a5050c18715d8e38e48783897f5dc59/comments" | ./jq-win64.exe '.'
