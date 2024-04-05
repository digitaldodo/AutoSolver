import subprocess
from bs4 import BeautifulSoup

lang="java"

stdio = subprocess.run(['./gfgPotd.sh'], stdout=subprocess.PIPE)
url = stdio.stdout.decode()

stdio = subprocess.run(['./gfgSolution.sh', url, lang], stdout=subprocess.PIPE)
json_string = stdio.stdout

soup = BeautifulSoup( json_string, 'html.parser')
elem = soup.find('code', class_='language-{}'.format(lang))
solution = repr(elem.text)[1:-1]

stdio = subprocess.run(['./gfgProblem.sh', url, lang], stdout=subprocess.PIPE)
initial_code = repr(stdio.stdout.decode())[1:-1]

final_solution = "{}\n{}".format(initial_code, solution)

stdio = subprocess.run(['./gfgSubmit.sh', url, repr(solution)[1:-1], repr(final_solution)[1:-1], lang], stdout=subprocess.PIPE)
submission_status = stdio.stdout.decode()

print(submission_status)
