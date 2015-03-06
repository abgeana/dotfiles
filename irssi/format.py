#! env python

#####
#
# Because of the fact that irssi likes to mess up my formatting within
# the theme file, I decided to make this scripts which normalizez the
# formatting with a simple command.
#
#####

f1 = open('reddress.theme', 'r')
f2 = open('reddress.fm.theme', 'w')

INDEX_EQUAL = 40

lines = f1.readlines()
for l in lines:
    nospl = l.replace(' ', '')                              # non space line
    if not nospl.startswith('#') and len(nospl) != 0 and '=' in l:
        ieq = l.find('=')                                   # find current index of '=' character
        l = l[:ieq] + (INDEX_EQUAL - ieq) * ' ' + l[ieq:]   # add spaces to push character to desired index

        insp = INDEX_EQUAL + 1                              # search for index of next non space character
        while l[insp] == ' ':
            insp += 1
        l = l[:INDEX_EQUAL + 1] + ' ' + l[insp:]            # place non space character next to '='
    if len(nospl) == 0:
        l = nospl                                           # replace lines with spaces to just a \n\r
    l = l.replace('\t', ' ' * 4)                            # finally replace tab chars with spaces
    l = l.replace('%K |', ' %r|')
    l = l.replace('%K|', '%r|')
    f2.write(l)

f1.close()
f2.close()
