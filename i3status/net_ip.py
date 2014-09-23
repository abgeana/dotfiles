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
import os
import urllib3
import calendar
import datetime as dt

NETIP_FILE = '/tmp/i3_netip'
DDG_URL = 'duckduckgo.com'
DDG_REQ_PATH = '/?q=my+ip'
DDG_STR = 'Your IP address is'

def unix_now():
    return calendar.timegm(dt.datetime.utcnow().utctimetuple())

def get_saved_info():
    # check if file even exists and return None otherwise
    if not os.path.isfile(NETIP_FILE):
        return None

    # if it does exist, attempt to read stuff from it
    try:
        data = []
        # open file for reading only
        with open(NETIP_FILE, 'r') as fhandle:
            # order is established on lines 75 - 79
            data.append(fhandle.readline()) # unix timestamp
            data.append(fhandle.readline()) # net ip
            data.append(fhandle.readline()) # geographic location
            data.append(fhandle.readline()) # tun ip (if it exists)
        # remove '\n' characters and emptry strings
        aux = []
        for item in data:
            item = item.replace('\n', '')
            if item != '':
                aux.append(item)
        return aux
    except IOError:
        # if something happens then let's not commit suicide here
        return None

def save_info(netip, loc, tunip = None):
    try:
        # open file for writing
        with open(NETIP_FILE, 'w') as fhandle:
            fhandle.write(str(unix_now()) + '\n')
            fhandle.write(netip + '\n')
            fhandle.write(loc + '\n')
            if tunip is not None:
                fhandle.write(tunip)
    except IOError, er:
        # if something happens, again, avoid suicide
        print er #pass

def ask_ddg():
    # open an ssl connection to DDG
    http = urllib3.HTTPSConnectionPool(DDG_URL, port = 443)
    # attempt to make GET request and timeout after 4s (function is called every 5s)
    try:
        resp = http.request('GET', DDG_REQ_PATH, timeout = 4)
        resp.close()
    except urllib3.exceptions.ConnectTimeoutError:
        return None # nope
    except urllib3.exceptions.MaxRetryError:
        return None # no suicide here
    except urllib3.exceptions.SSLError:
        return None # not even once

    # if it worked, parse output :)
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
    if '(' in ddgloc and ')' in ddgloc:
        idx5 = ddgloc.find('(')
        idx6 = ddgloc.rfind(')')
        if idx6 + 1 < len(ddgloc):
            ddgloc = ddgloc[:idx5] + ddgloc[idx6 + 1:]
        else:
            ddgloc = ddgloc[:idx5]
    ddgloc = ddgloc.replace(' ', '')
    return [ddgip, ddgloc]

# this method return a tuple with three items
# 1 - boolean which says if vpn is used
# 2 - net ip address
# 3 - geographic location
# 2 and 3 are obtained from duck duck go :)
def get_netip():
    # get saved info
    svinfo = get_saved_info()

    # first check for a tun interface
    tunip = None
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

    # verify against saved info
    do_ask_ddg = False
    if svinfo is not None:
        svunixts = svinfo[0]
        svnetip = svinfo[1]
        svloc = svinfo[2]
        if len(svinfo) == 4:
            svtunip = svinfo[3]
        else:
            svtunip = None
        if (unix_now() > int(svunixts) + (60 * 5)) or \
           (svtunip is None and tunip is not None) or \
           (svtunip is not None and tunip is None) or \
           (svtunip is not None and svtunip != tunip):
            do_ask_ddg = True
    else:
        do_ask_ddg = True

    # check ip if needed
    if do_ask_ddg:
        netip, loc = None, None
        ddg_resp = ask_ddg()
        if ddg_resp is not None:
            netip, loc = ddg_resp
            save_info(netip, loc, tunip)

        if tunip is not None:
            return (True, netip, loc)
        else:
            return (False, netip, loc)
    else:
        return (svtunip != None, svnetip, svloc)

if __name__ == '__main__':
    info = get_netip()
    print 'This script is supposed to be used by i3wrapper.py.'
    print 'For testing purposes though, this is what I get:'
    print 'Using a VPN: %s' % info[0]
    print 'Net IP: %s' % info[1]
    print 'Location: %s' % info[2]
