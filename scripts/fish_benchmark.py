#!/usr/bin/env python3

import subprocess
import time

count = 10

result = []
for i in range(10):
    start = time.time()
    out = subprocess.check_output('time --format=\'%e\' fish -i -c exit', shell=True, text=True)
    elapsed = time.time() - start
    print(elapsed)
