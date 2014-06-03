#! /usr/bin/python

# Copyright (c) 2014, Alexandru Geana
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import subprocess as sp
import os.path
import urllib3
import calendar
import datetime as dt

TUNIP_FILE = '/tmp/i3_tunip'
DDG_URL = 'duckduckgo.com'
DDG_REQ_PATH = '/?q=my+ip'
DDG_STR = 'Your IP address is'

def unix_now():
    return calendar.timegm(dt.datetime.utcnow().utctimetuple())

def get_saved_info():
    if not os.path.isfile(TUNIP_FILE):
        return []
    with open(TUNIP_FILE) as fhandle:
        outip = fhandle.readline()
        outip = outip.replace('\n', '')
        loc = fhandle.readline()
        loc = loc.replace('\n', '')
        tunip = fhandle.readline()
        tunip = tunip.replace('\n', '')
        unixts = fhandle.readline()
        return [outip, loc, tunip, unixts]
    return []

def save_info(outip, loc, tunip):
    with open(TUNIP_FILE, 'w') as fhandle:
        fhandle.write(outip + '\n')
        fhandle.write(loc + '\n')
        fhandle.write(tunip + '\n')
        fhandle.write(str(unix_now()))

def ask_ddg():
    http = urllib3.HTTPSConnectionPool(DDG_URL, port = 443)
    resp = http.request('GET', DDG_REQ_PATH)
    resp.close()
    idx1 = resp.data.find(DDG_STR)
    idx1 += len(DDG_STR) + 1
    idx2 = resp.data.find(' ', idx1)
    ddgip = resp.data[idx1 : idx2]
    idx3 = resp.data.find('>', idx2)
    idx4 = resp.data.find('<', idx3)
    ddgloc = resp.data[idx3 + 1 : idx4]
    if ',' in ddgloc:
        idx5 = ddgloc.rfind(',')
        ddgloc = ddgloc[idx5 + 2 : ]
    return [ddgip, ddgloc]

def get_tunip():
    # execute command "ip -f inet -o addr"
    p = sp.Popen('ip -f inet -o addr'.split(' '), stdout=sp.PIPE, stderr=sp.PIPE)
    out, err = p.communicate()
    # split each line
    out = out.split('\n')
    # check each device if it is a tun
    for line in out:
        if 'tun' in line:
            # if we find a tun device, extract the ip address
            start = line.find('inet')
            start = line.find(' ', start + 1)
            end = line.find(' ', start + 1)
            tunip = line[start + 1 : end]
            # verify ip address with the one in TUNIP_FILE
            info = get_saved_info()
            svoutip, svloc, svtunip, svunixts = '', '', '', '0'
            if len(info) != 0:
                svoutip, svloc, svtunip, svunixts = info
            if tunip != svtunip or unix_now() > int(svunixts) + (60 * 5):
                outip, loc = ask_ddg()
                save_info(outip, loc, tunip)
                return [outip, loc]
            else:
                return [svoutip, svloc]
    return []

if __name__ == '__main__':
    info = get_tunip()
    print 'This script is supposed to be used by i3wrapper.py.'
    print 'For testing purposes though, this is what I get:'
    if len(info) == 0:
        print 'Not using a VPN'
    else:
        print 'Tunnel IP: %s' % info[0]
        print 'Location: %s' % info[1]
        if len(info) == 3:
            print 'Outer IP: %s' % info[2]
