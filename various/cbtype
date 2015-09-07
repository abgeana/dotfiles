#! env python

from __future__ import print_function

import sys
import subprocess as sp

def main():
    try:
        xsel = sp.Popen('xsel -ob'.split(), stdout = sp.PIPE)
        xdotool = sp.Popen('xdotool -'.split(), stdin = sp.PIPE)
    except OSError:
        print('This script requires "xsel" and "xdotool" to be installed.', file = sys.stderr)
        exit(-1)

    cb = xsel.communicate()[0]
    xdotool.communicate(input = 'type ' + cb)

if __name__ == '__main__':
    main()
