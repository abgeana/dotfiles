#! env python3

import fileinput
import re

all_substitutions = [
    ['\(outlook:[0-9a-zA-Z]*\)', '(outlook)'],
    ['\(https?:[\-_/.0-9a-zA-Z]*\)', '(http)']
]


def substitute_text(line, old, new):
    new = new + ' ' * (len(old) - len(new))
    line = line.replace(old, new)
    return line


def apply_substitutions(line):
    for sub in all_substitutions:
        regex_string = '.*(?P<regex_group>{sub_regex}).*'.format(sub_regex=sub[0])
        match = re.match(regex_string, line)
        if match != None:
            line = substitute_text(line, match.group('regex_group'), sub[1])
    return line


def main():
    global all_substitutions
    output = str()
    for line in fileinput.input():
        line = apply_substitutions(line)
        output += line
    print(output, end="")


if __name__ == '__main__':
    main()
