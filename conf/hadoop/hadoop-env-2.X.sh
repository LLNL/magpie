# Copyright 2011 The Apache Software Foundation
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Set Hadoop-specific environment variables here.

# The only required environment variable is JAVA_HOME.  All others are
# optional.  When running a distributed configuration it is best to
# set JAVA_HOME in this file, so that it is correctly defined on
# remote nodes.

# The java implementation to use.
export JAVA_HOME=HADOOP_JAVA_HOME

# The jsvc implementation to use. Jsvc is required to run secure datanodes.
#export JSVC_HOME=${JSVC_HOME}

export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"HADOOPCONFDIR"}

# extras
export HADOOP_LOG_DIR="${HADOOP_LOG_DIR:-HADOOPLOGDIR}"
export HADOOP_HOME="${HADOOP_HOME:-HADOOPHOME}"
export HADOOP_COMMON_HOME="${HADOOP_COMMON_HOME:-HADOOPCOMMONHOME}"
export HADOOP_MAPRED_HOME="${HADOOP_MAPRED_HOME:-HADOOPMAPREDHOME}"
export HADOOP_HDFS_HOME="${HADOOP_HDFS_HOME:-HADOOPHDFSHOME}"

# Extra Java CLASSPATH elements.  Automatically insert capacity-scheduler.
for f in $HADOOP_HOME/contrib/capacity-scheduler/*.jar; do
  if [ "$HADOOP_CLASSPATH" ]; then
    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$f
  else
    export HADOOP_CLASSPATH=$f
  fi
done

export EXTRA_HADOOP_CLASSES="EXTRAHADOOPCLASSES"

if [ "${EXTRA_HADOOP_CLASSES}X" != "X" ]
then
  if [ "$HADOOP_CLASSPATH" ]; then
    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$EXTRA_HADOOP_CLASSES
  else
    export HADOOP_CLASSPATH=$EXTRA_HADOOP_CLASSES
  fi
fi

# The maximum amount of heap to use, in MB. Default is 1000.
export HADOOP_HEAPSIZE=HADOOP_DAEMON_HEAP_MAX
#export HADOOP_NAMENODE_INIT_HEAPSIZE=""

export EXTRA_HADOOP_OPTS="EXTRAHADOOPOPTS"

# Extra Java runtime options.  Empty by default.
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true $EXTRA_HADOOP_OPTS"

# Command specific options appended to HADOOP_OPTS when specified
export HADOOP_NAMENODE_OPTS="-XmxHADOOP_NAMENODE_HEAP_MAXm -Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_NAMENODE_OPTS"
export HADOOP_DATANODE_OPTS="-Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS"

export HADOOP_SECONDARYNAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_SECONDARYNAMENODE_OPTS"

# The following applies to multiple commands (fs, dfs, fsck, distcp etc)
export HADOOP_CLIENT_OPTS="-Xmx512m $HADOOP_CLIENT_OPTS"
#HADOOP_JAVA_PLATFORM_OPTS="-XX:-UsePerfData $HADOOP_JAVA_PLATFORM_OPTS"

# On secure datanodes, user to run the datanode as after dropping privileges
export HADOOP_SECURE_DN_USER=${HADOOP_SECURE_DN_USER}

# Where log files are stored.  $HADOOP_HOME/logs by default.
#export HADOOP_LOG_DIR=${HADOOP_LOG_DIR}/$USER

# Where log files are stored in the secure data environment.
export HADOOP_SECURE_DN_LOG_DIR=${HADOOP_LOG_DIR}/${HADOOP_HDFS_USER}

# The directory where pid files are stored. /tmp by default.
# NOTE: this should be set to a directory that can only be written to by
#       the user that will run the hadoop daemons.  Otherwise there is the
#       potential for a symlink attack.
export HADOOP_PID_DIR="${HADOOP_PID_DIR:-HADOOPPIDDIR}"
export HADOOP_MAPRED_PID_DIR="${HADOOP_MAPRED_PID_DIR:-HADOOPMAPREDPIDDIR}"
export HADOOP_SECURE_DN_PID_DIR=${HADOOP_PID_DIR}

# A string representing this instance of hadoop. $USER by default.
export HADOOP_IDENT_STRING=$USER

# Wait hopefully for more than default of 5 seconds before giving up
# on killing a daemon
export HADOOP_STOP_TIMEOUT=HADOOPTIMEOUTSECONDS
