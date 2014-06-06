'''
    This is not meant to be executed on its own. Instead, place this in the appropriate ipython profile directory.
    Configuration documentation available online at: http://ipython.org/ipython-doc/dev/config
    For a default profile on a fresh box:
        1) execute "ipython profile create"
        2) copy this file to ~/.ipython/profile_default
'''

import subprocess

# helper functions
def whoami():
    p = subprocess.Popen('whoami', stdout = subprocess.PIPE, stderr=subprocess.PIPE)
    out, _ = p.communicate()
    out = out.replace('\n', '')
    return out

# get Config object
c = get_config()

# do not display the banner
c.TerminalIPythonApp.display_banner = False

# startup execution of stuff
c.InteractiveShellApp.exec_lines = [
]

c.InteractiveShellApp.exec_files = [
]

# auto-indentation where appropriate
c.InteractiveShell.autoindent = True

# color variables to make life easier
cLCyan = '{color.LightCyan}'
cLBlue = '{color.LightBlue}'
cRed = '{color.Red}'
cGreen = '{color.Green}'
cBlue = '{color.Blue}'
cWhite = '{color.White}'

# root gets green, plebs get red
if whoami() == 'root':
    cUser = cGreen
else:
    cUser = cRed

# and the hostname appears white
cHost = cWhite

# prompt variables
prompt_start = cLCyan + '[IP] '
c.PromptManager.in_template = prompt_start + cUser + '\u' + cBlue + '  @  ' + cHost + '\h' + cBlue + '  : \Y0' + cLCyan + ' [\#' + cLCyan + '] '
c.PromptManager.in2_template = cLBlue + '>> '
c.PromptManager.out_template = cLCyan + '[\#' + cLCyan + '] '
c.PromptManager.justify = True
