#!/usr/bin/env bash

# This file contains environment variables required to run Tachyon. Copy it as tachyon-env.sh and
# edit that to configure Tachyon for your site. At a minimum,
# the following variables should be set:
#
# - JAVA_HOME, to point to your JAVA installation
# - TACHYON_MASTER_ADDRESS, to bind the master to a different IP address or hostname
# - TACHYON_UNDERFS_ADDRESS, to set the under filesystem address.
# - TACHYON_WORKER_MEMORY_SIZE, to set how much memory to use (e.g. 1000mb, 2gb) per worker
# - TACHYON_RAM_FOLDER, to set where worker stores in memory data
# - TACHYON_UNDERFS_HDFS_IMPL, to set which HDFS implementation to use (e.g. com.mapr.fs.MapRFileSystem,
#   org.apache.hadoop.hdfs.DistributedFileSystem)

# The following gives an example:

# Uncomment this section to add a local installation of Hadoop to Tachyon's CLASSPATH.
# The hadoop command must be in the path to automatically populate the Hadoop classpath.
#

export JAVA_HOME="TACHYON_JAVA_HOME"
export JAVA="$JAVA_HOME/bin/java"

TACHYON_HADOOP_CMD="TACHYONHADOOPCMD"
if [ "${TACHYON_HADOOP_CMD}X" != "X" ]
then
  export HADOOP_HOME="${HADOOP_HOME:-HADOOPHOME}"
  export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"HADOOPCONFDIR"}
  export HADOOP_TACHYON_CLASSPATH=`${TACHYON_HADOOP_CMD} classpath`
fi
export TACHYON_CLASSPATH=$HADOOP_TACHYON_CLASSPATH

export TACHYON_HOME="TACHYONHOME"

export TACHYON_LOCAL_DIR="TACHYONLOCALDIR"

export TACHYON_CONF_DIR="TACHYONCONFDIR"

# tachyon seems to have both "log" or "logs" within some scripts
export TACHYON_LOG_DIR="TACHYONLOGDIR"
export TACHYON_LOGS_DIR="TACHYONLOGDIR"

export TACHYON_MASTER_ADDRESS="TACHYONMASTERADDRESS"

export TACHYON_MASTER_PORT="TACHYONMASTERPORT"

export TACHYON_MASTER_WEB_PORT="TACHYONMASTERWEBPORT"

export TACHYON_WORKER_PORT="TACHYONWORKERPORT"

export TACHYON_WORKER_DATA_PORT="TACHYONWORKERDATAPORT"

export TACHYON_WORKER_MEMORY_SIZE="TACHYONWORKERMEMORYSIZE"

export TACHYON_HIERARCHYSTORE_TYPE="TACHYONHIERARCHYSTORETYPE"

export TACHYON_HIERARCHYSTORE_PATHS="TACHYONHIERARCHYSTOREPATHS"

export TACHYON_HIERARCHYSTORE_QUOTA="TACHYONHIERARCHYSTOREQUOTA"

# e.g. hdfs://host:9000
export TACHYON_UNDERFS_ADDRESS="TACHYONUNDERFSADDRESS"
export TACHYON_UNDERFS_HDFS_IMPL=org.apache.hadoop.hdfs.DistributedFileSystem

export TACHYON_JOURNAL_FOLDER="TACHYONJOURNALFOLDER"

export TACHYON_ASYNC_ENABLE="TACHYONASYNCENABLE"

export TACHYON_WRITETYPE_DEFAULT="TACHYONWRITETYPEDEFAULT"

# tachyon.worker.hierarchystore.level0.alias - MEM or SSD or HDD
# achu: is tachyon.worker.memory.size deprecated in 0.6.0?
# XXX tachyon journal only needed for failover? in local-dir good/bad?
export TACHYON_JAVA_OPTS+="
  -Dlog4j.configuration=file:${TACHYON_CONF_DIR}/log4j.properties
  -Dtachyon.debug=false
  -Dtachyon.home=${TACHYON_HOME} 
  -Dtachyon.master.hostname=${TACHYON_MASTER_ADDRESS}
  -Dtachyon.master.port=${TACHYON_MASTER_PORT}
  -Dtachyon.master.web.port=${TACHYON_MASTER_WEB_PORT}
  -Dtachyon.worker.port=${TACHYON_WORKER_PORT}
  -Dtachyon.worker.data.port=${TACHYON_WORKER_DATA_PORT} 
  -Dtachyon.worker.hierarchystore.level.max=1
  -Dtachyon.worker.hierarchystore.level0.alias=${TACHYON_HIERARCHYSTORE_TYPE}
  -Dtachyon.worker.hierarchystore.level0.dirs.path=${TACHYON_HIERARCHYSTORE_PATHS}
  -Dtachyon.worker.hierarchystore.level0.dirs.quota=${TACHYON_HIERARCHYSTORE_QUOTA}
  -Dtachyon.underfs.address=${TACHYON_UNDERFS_ADDRESS}
  -Dtachyon.underfs.hdfs.impl=${TACHYON_UNDERFS_HDFS_IMPL}
  -Dtachyon.data.folder=${TACHYON_UNDERFS_ADDRESS}/tmp/tachyon/data
  -Dtachyon.workers.folder=${TACHYON_UNDERFS_ADDRESS}/tmp/tachyon/workers
  -Dtachyon.worker.memory.size=${TACHYON_HIERARCHYSTORE_QUOTA}
  -Dtachyon.worker.data.folder=/tachyonworker/
  -Dtachyon.master.worker.timeout.ms=60000
  -Dtachyon.worker.user.timeout.ms=30000
  -Dtachyon.master.journal.folder=${TACHYON_JOURNAL_FOLDER}
  -Dtachyon.async.enabled=${TACHYON_ASYNC_ENABLE}
  -Dtachyon.user.file.writetype.default=${TACHYON_WRITETYPE_DEFAULT}
"

# Master specific parameters. Default to TACHYON_JAVA_OPTS.
export TACHYON_MASTER_JAVA_OPTS="$TACHYON_JAVA_OPTS"

# Worker specific parameters that will be shared to all workers. Default to TACHYON_JAVA_OPTS.
export TACHYON_WORKER_JAVA_OPTS="$TACHYON_JAVA_OPTS"
