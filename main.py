import subprocess
from bs4 import BeautifulSoup

lang="java"

stdio = subprocess.run(['./gfgPotd.sh'], stdout=subprocess.PIPE)
url = stdio.stdout.decode()

stdio = subprocess.run(['./gfgSolution.sh', url, lang], stdout=subprocess.PIPE)
json_string = stdio.stdout

soup = BeautifulSoup( json_string, 'html.parser')
elem = soup.find('code', class_='language-{}'.format(lang))
solution = elem.text

stdio = subprocess.run(['./gfgProblem.sh', url, lang], stdout=subprocess.PIPE)
initial_code = stdio.stdout.decode()

final_solution = "{}\n{}".format(initial_code, solution)

stdio = subprocess.run(['./gfgSubmit.sh', url, solution, final_solution, lang], stdout=subprocess.PIPE)
submission_status = stdio.stdout.decode()

print(submission_status)
