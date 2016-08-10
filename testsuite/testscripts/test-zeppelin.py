#!/usr/bin/env python

import os
import urllib2

master_url = "http://" + os.environ['ZEPPELIN_MASTER_NODE'] + ":" + os.environ['ZEPPELIN_SERVER_PORT']

response = urllib2.urlopen(master_url).getcode()

if response == 200:
    print "Success"
    return 0
else:
    print "Invalid response code:", response
    return 1
