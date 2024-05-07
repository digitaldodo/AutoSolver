import sys
import subprocess
from bs4 import BeautifulSoup

lang_map = {
    "java": "java",
    "cpp": "cpp",
    # "python": "python3",
}

def get_final_solution(initial_code, solution, lang):
    if lang == "java":
        final_solution = "{}\n{}".format(initial_code, solution)
    elif lang == "cpp":
        if initial_code.find("int main") != -1:
            final_solution = initial_code.replace("int main", "{}\nint main".format(solution))
        else :
            final_solution = "{}\n{}".format(initial_code, solution)
    else :
        final_solution = "{}\n{}".format(initial_code, solution)
    return final_solution


def submit(lang="java"):
    stdio = subprocess.run(['./gfgPotd.sh'], stdout=subprocess.PIPE)
    url = stdio.stdout.decode()

    stdio = subprocess.run(['./gfgSolution.sh', url, lang], stdout=subprocess.PIPE)
    json_string = stdio.stdout

    soup = BeautifulSoup( json_string, 'html.parser')
    elem = soup.find('code', class_='language-{}'.format(lang))
    solution = repr(elem.text)[1:-1]

    stdio = subprocess.run(['./gfgProblem.sh', url, lang], stdout=subprocess.PIPE)
    initial_code = stdio.stdout.decode()

    final_solution = get_final_solution(initial_code, solution, lang)

    stdio = subprocess.run(['./gfgSubmit.sh', url, solution, final_solution, lang_map[lang] ], stdout=subprocess.PIPE)
    submission_status = stdio.stdout.decode()
    print(submission_status)

if __name__ == "__main__":
    lang = sys.argv[1] if len(sys.argv) > 1 else "java"
    if lang not in lang_map:
        print("Invalid language")
        print("Supported languages are: ", lang_map.keys())
    else:
        submit(lang)
