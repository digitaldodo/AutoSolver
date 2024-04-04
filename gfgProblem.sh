#!/bin/bash

env_path=decoy_creds.env
. ./load_dotenv $env_path

url=$1
slug=$(echo "$url" | grep -oP '(?<=problems\/).*?(?=\/)')
lang=java

echo "Fetching solution for $slug"

res=$(curl "https://practiceapi.geeksforgeeks.org/api/latest/problems/$slug/metainfo/?" \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H "cookie: authtoken=$authtoken; gfg_nluid=$gfg_nluid; gfguserName=$gfguserName; gfg_id5_identity=$gfg_id5_identity" \
  -H 'dnt: 1' \
  -H 'origin: https://www.geeksforgeeks.org' \
  -H 'pragma: no-cache' \
  -H 'referer: https://www.geeksforgeeks.org/' \
  -H 'sec-ch-ua: "Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36')

json_string=$(echo "$res" | jq -r ".results.extra.initial_user_func.$lang.initial_code")

echo "$json_string"
