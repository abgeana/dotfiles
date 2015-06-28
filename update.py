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
        print('Updating %s...' % self._program)
        for f in self._files:
            print('%s ' % f.local, end = '')
            ret = self._download_file(f.local, f.remote)
            if ret == 0:
                print('[ OK ]')
            else:
                print('[ FAIL ]')
        print()

    def _download_file(self, local, remote):
        if self._folder is not None:
            remote_url = Config._base_url + self._folder + '/' + remote
        else:
            remote_url = Config._base_url + '/' + remote
        return self._exec([ \
            'curl', '-o', \
            local, \
            remote_url \
        ])

    def _exec(self, cmd):
        p = sp.Popen(cmd, stdout = sp.PIPE, stderr = sp.PIPE)
        p.communicate()
        return p.returncode

def main():
    home = os.getenv('HOME')
    configs = {}
    update_list = []

    configs['self'] = Config('update script', None, \
        [ File(os.path.abspath(sys.argv[0]), 'update.py') ])

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

    configs['inputrc'] = Config('inputrc', 'inputrc', \
        [ File(j(home, '.inputrc'), 'inputrc') ])

    configs['x11'] = Config('X11', 'X11', \
        [ File(j(home, '.Xresources'), 'Xresources') ])

    configs['gpg'] = Config('GnuPG', 'gnupg', \
        [ File(j(home, '.gnupg', 'gpg-agent.conf'), 'gpg-agent.conf'), \
          File(j(home, '.gnupg', 'gpg.conf'), 'gpg.conf') ])

    if len(sys.argv) > 1:
        for idx in range( 1, len(sys.argv) ):
            update_list.append(sys.argv[idx])
        update_list = set(update_list)
    else:
        update_list.extend(configs.keys())

    for item in update_list:
        if item in configs:
            configs[item].update()

if __name__ == '__main__':
    main()
