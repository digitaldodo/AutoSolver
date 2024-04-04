#!/bin/bash

env_path=real_creds.env
. ./load_dotenv $env_path

url=$1
userCode=$3
code=$4
lang=$2

slug=$(echo "$url" | grep -oP '(?<=problems\/).*?(?=\/)')

submit_url="https://practiceapiorigin.geeksforgeeks.org/api/latest/problems/$slug/submit/compile/"

echo "submitting solution for $slug"

boundary=----WebKitFormBoundaryxPO4AnE9XjwVk6AA

data_raw="$boundary
Content-Disposition: form-data; name=\"source\"

https://www.geeksforgeeks.org
$boundary
Content-Disposition: form-data; name=\"request_type\"

solutionCheck
$boundary
Content-Disposition: form-data; name=\"userCode\"

$userCode
$boundary
Content-Disposition: form-data; name=\"code\"

$code
$boundary
Content-Disposition: form-data; name=\"language\"

$lang
$boundary--
"

res=$(curl $submit_url \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H "content-type: multipart/form-data; boundary=$boundary" \
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
  -d "$data_raw"  \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36' -v)

echo "$res"
