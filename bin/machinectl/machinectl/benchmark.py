import subprocess
import re
import time
import json

count = 10


def __fish() -> list[dict[str, str]]:
    result = []
    for _ in range(count):
        start = time.time()
        subprocess.check_output("fish -i -c exit", shell=True)
        elapsed = time.time() - start
        result.append(elapsed)

    average = sum(result) / len(result)

    return [
        {
            "name": "fish startup time (average)",
            "unit": "msec",
            "value": str(average * 100),
        }
    ]


def __vim() -> list[dict[str, str]]:
    cmd = "vim-startuptime -vimpath nvim -count {count}".format(count=count)
    value_regexp = r"[0-9]*\.[0-9]*"

    out = subprocess.check_output(cmd, shell=True).decode("utf-8")
    total_average = re.findall(r"Total Average:\s*[0-9.]*\smsec", out)
    total_max = re.findall(r"Total Max:\s*[0-9\.]*\smsec", out)
    total_min = re.findall(r"Total Min:\s*[0-9\.]*\smsec", out)

    total_average_time = re.findall(value_regexp, total_average[0])[0]
    total_max_time = re.findall(value_regexp, total_max[0])[0]
    total_min_time = re.findall(value_regexp, total_min[0])[0]

    return [
        {
            "name": "vim startup time (average)",
            "unit": "msec",
            "value": total_average_time,
        },
        {
            "name": "vim startup time (max)",
            "unit": "msec",
            "value": total_max_time,
        },
        {
            "name": "vim startup time (min)",
            "unit": "msec",
            "value": total_min_time,
        },
    ]


def run():
    result = []
    result.extend(__fish())
    result.extend(__vim())
    print(json.dumps(result))
