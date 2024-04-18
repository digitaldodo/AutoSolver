#!/bin/bash

env_path=real_creds.env
. ./load_dotenv $env_path

set -o noglob

url=$1
userCode=$2
code=$3
lang=$4

slug=$(echo "$url" | sed -n 's/.*problems\/\([^/]*\).*/\1/p')

submit_url="https://practiceapiorigin.geeksforgeeks.org/api/latest/problems/$slug/submit/compile/"

echo "submitting solution for $slug"

boundary=------WebKitFormBoundarydAZWanv03P3ErADp

data_raw="
------WebKitFormBoundarydAZWanv03P3ErADp
Content-Disposition: form-data; name=\"source\"\r\n\r\nhttps://www.geeksforgeeks.org\r\n------WebKitFormBoundarydAZWanv03P3ErADp
Content-Disposition: form-data; name=\"request_type\"\r\n\r\nsolutionCheck\r\n------WebKitFormBoundarydAZWanv03P3ErADp
Content-Disposition: form-data; name=\"userCode\"\r\n\r\n$(echo -e $userCode)\r\n------WebKitFormBoundarydAZWanv03P3ErADp
Content-Disposition: form-data; name=\"code\"\r\n\r\n$(echo -e $code)\r\n------WebKitFormBoundarydAZWanv03P3ErADp
Content-Disposition: form-data; name=\"language\"\r\n\r\n$lang\r\n------WebKitFormBoundarydAZWanv03P3ErADp--
"

echo "======================================================"
echo -e $data_raw
echo "======================================================"

res=$(curl $submit_url \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundarydAZWanv03P3ErADp' \
  -H "cookie: gfg_nluid=$gfg_nluid; gfguserName=$gfguserName; gfg_id5_identity=$gfg_id5_identity" \
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
  --data-raw "$(echo -e $data_raw)" \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36')

echo "$res"
