# This is a python script to be executed via python
#
# This was cut & pasted from the ray documentation

from __future__ import print_function

import os
import ray
import time

try:
  rayaddress = os.environ['MAGPIE_RAY_ADDRESS']
  nodecount = int(os.environ['MAGPIE_NODE_COUNT'])
except:
  print ("Missing Magpie environment variable")
  exit (1)

ray.init(redis_address=rayaddress)

@ray.remote
def f():
    time.sleep(0.01)
    return ray.services.get_node_ip_address()

# Get a list of the IP addresses of the nodes that have joined the cluster.
ips=set(ray.get([f.remote() for _ in range(nodecount)]))

for ip in ips:
  print(ip)
