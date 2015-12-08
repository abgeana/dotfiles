'''
    This is not meant to be executed on its own. Instead, place this in the appropriate ipython profile directory.
    Configuration documentation available online at: http://ipython.org/ipython-doc/dev/config
    For a default profile on a fresh box:
        1) execute "ipython profile create"
        2) copy this file to ~/.ipython/profile_default
'''

# get Config object
c = get_config()

###
#   interactive shell configs
###
c.InteractiveShell.autoindent = True        # auto-indentation where appropriate
c.InteractiveShell.confirm_exit = False     # exit without asking
c.InteractiveShell.editor = 'vim'           # vim as editor
c.InteractiveShellApp.exec_lines = [        # startup execution of stuff
    'import numpy as np',
    'import os, os.path',
    'import sys'
]

###
#   terminal app configs
###
c.TerminalIPythonApp.display_banner = False # do not display the banner

###
#   aliases
###

c.AliasManager.user_aliases = [
    ('lss', 'ls --color=tty -Alh')
]

###
#   the prompt
###

# color variables to make life easier
cLCyan  = '{color.LightCyan}'
cLBlue  = '{color.LightBlue}'
cRed    = '{color.Red}'
cGreen  = '{color.Green}'
cBlue   = '{color.Blue}'
cWhite  = '{color.White}'

# prompt variables
prompt_start = cLCyan + '[IP] '
c.PromptManager.in_template = cLCyan + 'IPython ' + cGreen + '[\#' + cGreen + ']' + cLCyan + ' <<< '
c.PromptManager.in2_template = cLCyan + '<<< '
c.PromptManager.out_template = cGreen + '[\#' + cGreen + ']' + cLCyan + ' >>> '
c.PromptManager.justify = True
