#!/bin/bash

url=https://practiceapi.geeksforgeeks.org/api/vr/problems-of-day/problem/today/

res=$(curl $url \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
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

json_string=$(echo "$res" | jq -r '.problem_url')

echo "$json_string"
