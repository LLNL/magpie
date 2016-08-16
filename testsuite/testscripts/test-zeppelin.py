#!/usr/bin/env python

import os
import urllib2

master_url = "http://" + os.environ['ZEPPELIN_MASTER_NODE'] + ":" + os.environ['ZEPPELIN_SERVER_PORT']

print "Attempting to connect to: ", master_url

response = urllib2.urlopen(master_url).getcode()

if response == 200:
    print "Success connecting to Zeppelin"
else:
    print "Failed connecting to Zeppelin - invalid response code:", response
