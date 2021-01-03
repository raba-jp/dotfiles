#!/usr/bin/python

# To activate: complete --command gcloud --arguments="(/path/gcloud_completion.py (commandline -cp))"

import re
import subprocess
import sys

def parse_help(h):
    commands = {}
    cmd = ""
    desc = ""
    processing = False
    for line in h.split("\n"):
        if re.match(r"[^ ]", line):
            processing = line in set(["GROUPS", "COMMANDS"]) or "FLAGS" in line
        if processing:
            if re.match(r"     [^ ]", line):
                if cmd:
                    commands[cmd] = desc.strip()
                    desc = ""
                cmd = line.strip().split(",")[0]#.split(" ")[0]
            elif line.startswith("        "):
                desc += " " + line.strip()
    if cmd and processing:
        commands[cmd] = desc.strip()
    return commands

def get_autocomplete(args):
    test_args = []
    cmds = {}
    for arg in args:
        cmds = parse_help(subprocess.check_output(["gcloud"] + test_args + ["--help"]))
        if arg in cmds:
            test_args.append(arg)
        else:
            return {k: v for k, v in cmds.iteritems() if k.startswith(arg)}
    return parse_help(subprocess.check_output(["gcloud"] + test_args + ["--help"]))

if __name__ == "__main__":

    try:
        args = sys.argv[1].split(" ")[1:] if len(sys.argv) > 1 else []
        show_flags = args[-1].startswith("-") if len(args) > 0 else False

        for k, v in get_autocomplete(args).iteritems():
            if k.startswith("-"):
                if show_flags:
                    print k + "\t" + v
            else:
                print k + "\t" + v
    except Exception as err:
        with open("/tmp/gcloud_autocomplete.err", "w") as f:
            f.write(str(sys.argv) + "\n")
            f.write(str(err) + "\n")
