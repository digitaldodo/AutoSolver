# GFG_POTD_SOLVER
This is a simple project which aims to:
- automatically pull potd
- fetch correct solution from editorial
- submit the solution

# Credentials
For this to work as exected, It needs two sets of credentials:
1. Decoy creds
  - This is used to fetch solutions
  - location:  `decoy_creds.env`
2. Real creds
  - Used at time of submission
  - Submissions will reflect on this account
  - location: `real_creds.env`
3. Empty creds
  - used to clear previously set creds on runtime
  - use it as a reference while creating `decoy_creds.env` and `real_creds.env`

# Pre-requisites
1. Python3
2. Bash -> (/bin/bash)
3. Grep

All the above commands should be accessible to the current user.

# Usage guide
1. Create two accounts on GFG, if you already don't have it
2. grab the cookies of both accounts and put it in their respective env files
3. Install requirements using pip
```sh
pip install -r requirements.txt
```
4. start the script
```sh
python3 main.py
```

# Anything else
- Schedule a cron-job to run the script automatically daily

# FAQ
1. How to get cookies ?
   - Open the browser
   - Visit official GFG website
   - open developer tools in your browser
   - head over to cookies section
     - Chrome: application -> storage -> cookies
     - Firefox: storage -> cookies
   - Copy the required cookies
2. How to open developer tools ?
   - Leave it dude, Its not for everyone xD
