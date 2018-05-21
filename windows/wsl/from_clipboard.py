#! env python3

from subprocess import check_output

data = check_output('powershell.exe Get-Clipboard -Format Text -Raw'.split(' '))
data = str(data, 'utf-8')

# convert \r\n line terminators used by windows into only \n
data = data.replace('\r\n', '\n')

# drop the last \r\n (now just a \n) added by powershell
data = data[:-1]

print(data, end='')
