#! env python3

import sys
from subprocess import call

lines = ''.join(sys.stdin.readlines())

# windows uses \r\n instead of \n line terminators
lines = lines.replace('\n', '\r\n')
# the backtick ` character is used to escape other characters
lines = lines.replace('`', '``')
# the double quotes are used in this script
lines = lines.replace('"', '`"')

cmd = 'powershell.exe Set-Clipboard -Value'.split(' ')
cmd.append('"' + lines + '"')

call(cmd, shell=False)
