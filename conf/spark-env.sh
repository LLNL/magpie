#!/usr/bin/env bash

# This file contains environment variables required to run Spark. Copy it as
# spark-env.sh and edit that to configure Spark for your site.
#
# The following variables can be set in this file:
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - MESOS_NATIVE_LIBRARY, to point to your libmesos.so if you use Mesos
# - SPARK_JAVA_OPTS, to set node-specific JVM options for Spark. Note that
#   we recommend setting app-wide options in the application's driver program.
#     Examples of node-specific options : -Dspark.local.dir, GC options
#     Examples of app-wide options : -Dspark.serializer
#
# If using the standalone deploy mode, you can also set variables for it here:
# - SPARK_MASTER_IP, to bind the master to a different IP address or hostname
# - SPARK_MASTER_PORT / SPARK_MASTER_WEBUI_PORT, to use non-default ports
# - SPARK_WORKER_CORES, to set the number of cores to use on this machine
# - SPARK_WORKER_MEMORY, to set how much memory to use (e.g. 1000m, 2g)
# - SPARK_WORKER_PORT / SPARK_WORKER_WEBUI_PORT
# - SPARK_WORKER_INSTANCES, to set the number of worker processes per node
# - SPARK_WORKER_DIR, to set the working directory of worker processes

# Additional
# SPARK_DAEMON_MEMORY Memory to allocate to the Spark master and
#   worker daemons themselves (default: 512m).
# SPARK_DAEMON_JAVA_OPTS JVM options for the Spark master and worker
#   daemons themselves (default: none).
# PYSPARK_PYTHON, the Python binary to use for PySpark
# SPARK_LIBRARY_PATH, to add search directories for native libraries.
# SPARK_CLASSPATH, to add elements to s classpath that you want to be
#   present for all applications. Note that applications can also add
#   dependencies for themselves through SparkContext.addJar
#   SPARK_JAVA_OPTS, t#o add JVM options. This includes Java options
#   like garbage collector settings and any system properties that d
#   like to pass with -D (e.g., -Dspark.local.dir=/disk1,/disk2).

export JAVA_HOME="SPARK_JAVA_HOME"

export SPARK_DAEMON_MEMORY="SPARK_DAEMON_HEAP_MAXm"

export SPARK_WORKER_CORES="SPARKWORKERCORES"

export SPARK_WORKER_MEMORY="SPARKWORKERMEMORYm"

export SPARK_WORKER_DIR="SPARKWORKERDIR"

export SPARK_MEM="SPARKMEMm"
