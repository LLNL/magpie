# This is a python script to be executed via python

from __future__ import print_function

import os
import socket
import tensorflow as tf

try:
  hosts = os.environ['MAGPIE_TENSORFLOW_HOSTS']
  rank = int(os.environ['MAGPIE_TENSORFLOW_RANK'])
  maxrank = int(os.environ['MAGPIE_TENSORFLOW_MAX_RANK'])
except:
  print ("Missing Magpie environment variable")
  exit (1)

# print(socket.gethostname(), hosts)
# print(socket.gethostname(), rank)
# print(socket.gethostname(), maxrank)

tf_hosts = hosts.split(",")

cluster = tf.train.ClusterSpec({"magpietfadd" : tf_hosts })

server = tf.train.Server(cluster,
                         job_name="magpietfadd",
                         task_index=rank)

if rank == 0:
  with tf.device("/job:magpietfadd/task:0"):
    a = tf.constant(100)

  with tf.device("/job:magpietfadd/task:1"):
    b = tf.constant(100)

  with tf.Session("grpc://%s" % tf_hosts[0]) as sess:
    c = sess.run(a+b)
    print("Distributed Addition = ", c);
    sess.close()
else:
  server.join()
