#!/usr/bin/env python3

import json
from os.path import expanduser
import plistlib
import sys

path = expanduser("~/Library/Preferences/com.apple.symbolichotkeys.plist")
with open(path, "rb") as f:
    plist = plistlib.load(f)

print(json.dumps(plist))
