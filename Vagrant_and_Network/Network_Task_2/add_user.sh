#!/bin/bash

 curl --request POST --header "PRIVATE-TOKEN: $API_KEY" \
      --data "user_id=63813&access_level=30" "https://git.epam.com/api/v4/projects/122669/members" | ./jq-win64.exe '.'

