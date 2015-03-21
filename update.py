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
    configs = {}
    updated_files = []

    configs['tmux'] = Config('tmux multiplexer', 'tmux', \
        [ File(j(home, '.tmux.conf'), 'tmux.conf'), \
          File(j(home, '.tmux.conf.ssh'), 'tmux.conf.ssh'), \
          File(j(home, '.tmux.common'), 'tmux.common') ])

    configs['ssh-tmux'] = Config('tmux ssh setup', 'tmux', \
        [ File(j(home, '.tmux.conf.ssh'), 'tmux.conf.ssh'), \
          File(j(home, 'ssh-tmux'), 'ssh-tmux') ])

    configs['vim'] = Config('vim editor', 'vim', \
        [ File(j(home, '.vimrc'), 'vimrc') ])

    configs['zsh'] = Config('zsh shell', 'zsh', \
        [ File(j(home, '.zshrc'), 'zshrc') ])

    configs['i3wm'] = Config('i3 status bar', 'i3wm', \
        [ File(j(home, '.i3status.conf'), 'i3status.conf'), \
          File(j(home, '.i3', 'config'), 'config'), \
          File(j(home, '.i3', 'i3wrapper.py'), 'i3wrapper.py'), \
          File(j(home, '.i3', 'net_ip.py'), 'net_ip.py') ])

    configs['irssi'] = Config('irssi IRC client', 'irssi', \
        [ File(j(home, '.irssi', 'reddress.theme'), 'reddress.theme') ])

    for arg in sys.argv:
        if arg in updated_files:
            continue
        updated_files.append(arg)

        if arg in configs:
            configs[arg].update()

if __name__ == '__main__':
    main()
