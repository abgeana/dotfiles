# https://github.com/ranger/ranger/wiki/Custom-Commands

from ranger.api.commands import Command

class trash(Command):
    """:trash

    Move selected file to the trash folder using trash-cli
    """
    def execute(self):
        for s in self.fm.thistab.get_selection():
            self.fm.execute_command(['trash', s.realpath])
        self.fm.notify('Files moved to trash.')
