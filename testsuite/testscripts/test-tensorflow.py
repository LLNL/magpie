# This is a python script to be executed via python

from __future__ import print_function

import os
import socket
import tensorflow as tf

try:
  hosts = os.environ['MAGPIE_TENSORFLOW_HOSTS']
  rank = int(os.environ['MAGPIE_TENSORFLOW_RANK'])
except:
  print ("Missing Magpie environment variable")
  exit (1)

tf_hosts = hosts.split(",")

cluster = tf.train.ClusterSpec({"magpietest" : tf_hosts })

server = tf.train.Server(cluster,
                         job_name="magpietest",
                         task_index=rank)

if rank == 0:
  with tf.device("/job:magpietest/task:0"):
    a = tf.constant(50)

  with tf.device("/job:magpietest/task:1"):
    b = tf.constant(50)

  with tf.Session("grpc://%s" % tf_hosts[0]) as sess:
    c = sess.run(a+b)
    print("Distributed Addition =", c);
    sess.close()
else:
  server.join()
