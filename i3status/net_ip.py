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
import ipcalc

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

def save_info(netip, loc):
    try:
        # open file for writing
        with open(NETIP_FILE, 'w') as fhandle:
            fhandle.write(str(unix_now()) + '\n')
            fhandle.write(netip + '\n')
            fhandle.write(loc + '\n')
    except IOError, er:
        # if something happens, again, avoid suicide
        pass

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

    # assume vpn is not used
    vpn_used = False

    # get ip of gateway in default route
    gwip = None
    p = sp.Popen('ip route list'.split(' '), stdout=sp.PIPE, stderr=sp.PIPE)
    routes, _ = p.communicate()
    p = sp.Popen('grep default'.split(' '), stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.PIPE)
    def_route, _ = p.communicate(input=routes)
    if def_route != '':
        # we found a default route, let's get the gateway ip
        idx_gwip = def_route.find('via ')
        idx_gwip += len('via ')
        def_route = def_route[idx_gwip:]
        gwip = def_route[:def_route.find(' ')]

    # get a list of all tun routes
    p = sp.Popen('grep tun'.split(' '), stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.PIPE)
    tun_routes, _ = p.communicate(input=routes)
    tun_routes = tun_routes.split('\n')
    for route in tun_routes:
        if route != '':
            backbone = route[:route.find(' ')]
            if gwip in ipcalc.Network(backbone):
                # default gateway is in tun network
                vpn_used = True

    # verify against saved info
    do_ask_ddg = False
    if svinfo is not None:
        svunixts = svinfo[0]
        svnetip = svinfo[1]
        svloc = svinfo[2]
        if unix_now() > int(svunixts) + (60 * 5):
            do_ask_ddg = True
    else:
        do_ask_ddg = True

    # check ip if needed
    if do_ask_ddg:
        netip, loc = None, None
        ddg_resp = ask_ddg()
        if ddg_resp is not None:
            netip, loc = ddg_resp
            save_info(netip, loc)
        return (vpn_used, netip, loc)
    else:
        return (vpn_used, svnetip, svloc)

if __name__ == '__main__':
    info = get_netip()
    print 'This script is supposed to be used by i3wrapper.py.'
    print 'For testing purposes though, this is what I get:'
    print 'Using a VPN: %s' % info[0]
    print 'Net IP: %s' % info[1]
    print 'Location: %s' % info[2]
