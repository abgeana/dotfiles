#! env python

from __future__ import print_function
import sys, os, subprocess as sp
from os.path import join as j

class File(object):

    def __init__(self, local, remote):
        self.local = local
        self.remote = remote

class Config(object):

    _base_url = 'https://raw.githubusercontent.com/alegen/alegen-configs/master/'

    def __init__(self, program, folder, files):
        self._program = program
        self._folder = folder
        self._files = files

    def update(self):
        print('Updating files for %s...' % self._program)
        for f in self._files:
            print('%s ' % f.local, end = '')
            ret = self._download_file(f.local, f.remote)
            if ret == 0:
                print('[ OK ]')
            else:
                print('[ FAIL ]')
        print()

    def _download_file(self, local, remote):
        return self._exec([ \
            'curl', '-o', \
            local, \
            Config._base_url + self._folder + '/' + remote \
        ])

    def _exec(self, cmd):
        p = sp.Popen(cmd, stdout = sp.PIPE, stderr = sp.PIPE)
        p.communicate()
        return p.returncode

def main():
    home = os.getenv('HOME')

    tmux = Config('tmux multiplexer', 'tmux', \
        [ File(j(home, '.tmux.conf'), 'tmux.conf'), \
          File(j(home, '.tmux.conf.ssh'), 'tmux.conf.ssh'), \
          File(j(home, '.tmux.common'), 'tmux.common') ])
    tmux_updated = False

    ssh_tmux = Config('tmux ssh setup', 'tmux', \
        [ File(j(home, '.tmux.conf.ssh'), 'tmux.conf.ssh'), \
          File(j(home, 'ssh-tmux'), 'ssh-tmux') ])
    ssh_tmux_updated = False

    vim = Config('vim editor', 'vim', \
        [ File(j(home, '.vimrc'), 'vimrc') ])
    vim_updated = False

    zsh = Config('zsh shell', 'zsh', \
        [ File(j(home, '.zshrc'), 'zshrc') ])
    zsh_updated = False

    i3wm = Config('i3 status bar', 'i3wm', \
        [ File(j(home, '.i3status.conf'), 'i3status.conf'), \
          File(j(home, '.i3', 'config'), 'config'), \
          File(j(home, '.i3', 'i3wrapper.py'), 'i3wrapper.py'), \
          File(j(home, '.i3', 'net_ip.py'), 'net_ip.py') ])
    i3wm_updated = False

    for arg in sys.argv:
        if arg == 'tmux' and not tmux_updated:
            tmux.update()
            tmux_updated = True

        if arg == 'ssh-tmux' and not ssh_tmux_updated:
            ssh_tmux.update()
            ssh_tmux_updated = True

        if arg == 'vim' and not vim_updated:
            vim.update()
            vim_updated = True

        if arg == 'zsh' and not zsh_updated:
            zsh.update()
            zsh_updated = True

        if arg == 'i3wm' and not i3wm_updated:
            i3wm.update()
            i3wm_updated = True

if __name__ == '__main__':
    main()
