'''
    This is not meant to be executed on its own. Instead, place this in the appropriate ipython profile directory.
    For a default profile on a fresh box:
        1) execute "ipython profile create"
        2) copy this file to ~/.ipython/profile_default

    Most up-to-date documentation on how to configure IPython is found at:
    https://ipython.readthedocs.io/en/stable/index.html
'''

import os
from IPython.terminal.interactiveshell import TerminalInteractiveShell
from IPython.terminal.prompts import Prompts, Token

# custom prompt
# the class below is inspired from the default Prompts class source code
# more info at https://ipython.readthedocs.io/en/stable/config/details.html
class AlegenPrompt(Prompts):

    def in_prompt_tokens(self, cli=None):
        return [
            (Token.Prompt, '[ '),
            (Token.PromptNum, str(self.shell.execution_count)),
            (Token.Prompt, ' >>> '),
        ]

    def continuation_prompt_tokens(self, cli = None, width = None):
        if width is None:
            width = self._width()
        return [
            (Token.Prompt, (' ' * (width - 5)) + '...: '),
        ]

    def rewrite_prompt_tokens(self):
        width = self._width()
        return [
            (Token.Prompt, ('-' * (width - 2)) + '> '),
        ]

    def out_prompt_tokens(self):
        return [
            (Token.OutPrompt, '[ '),
            (Token.OutPromptNum, str(self.shell.execution_count)),
            (Token.OutPrompt, ' <<< '),
        ]

TerminalInteractiveShell.autoindent = True              # auto-indentation where appropriate
TerminalInteractiveShell.confirm_exit = False           # exit without asking
TerminalInteractiveShell.editor = 'vim'                 # vim as editor
TerminalInteractiveShell.editing_mode = 'vi'            # vim as editor
TerminalInteractiveShell.prompts_class = AlegenPrompt

c = get_config()
c.TerminalIPythonApp.display_banner = False             # do not display the banner
c.InteractiveShellApp.exec_lines = [
    'import numpy as np',
    'import os, os.path',
    'import sys'
]
c.AliasManager.user_aliases = [                         # aliases
    ('lss', 'ls --color=tty -Alh')
]
