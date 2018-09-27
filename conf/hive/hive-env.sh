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

# Set Hive and Hadoop environment variables here. These variables can be used
# to control the execution of Hive. It should be used by admins to configure
# the Hive installation (so that users do not have to set environment variables
# or set command line parameters to get correct behavior).
#
# The hive service being invoked (CLI/HWI etc.) is available via the environment
# variable SERVICE


# Hive Client memory usage can be an issue if a large number of clients
# are running at the same time. The flags below have been useful in 
# reducing memory usage:
#
# if [ "$SERVICE" = "cli" ]; then
#   if [ -z "$DEBUG" ]; then
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:+UseParNewGC -XX:-UseGCOverheadLimit"
#   else
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:-UseGCOverheadLimit"
#   fi
# fi

# The heap size of the jvm stared by hive shell script can be controlled via:
#
# export HADOOP_HEAPSIZE=1024
#
# Larger heap size may be required when running queries over large number of files or partitions. 
# By default hive shell scripts use a heap size of 256 (MB).  Larger heap size would also be 
# appropriate for hive server (hwi etc).


# Set HADOOP_HOME to point to a specific hadoop install directory
# HADOOP_HOME=${bin}/../../hadoop

export JAVA_HOME="${JAVA_HOME:-HIVEJAVAHOME}"

export HIVE_MASTER_NODE="${HIVE_MASTER_NODE:-HIVEMASTERNODE}"

# Hive Configuration Directory can be controlled by:
export HIVE_CONF_DIR="${HIVE_CONF_DIR:-HIVECONFIGDIR}"

export HIVE_LOG_DIR="${HIVE_LOG_DIR:-HIVELOGDIR}"

export HIVE_METASTORE_DIR="${HIVE_METASTORE_DIR:-HIVEMETASTOREDIR}"

export HIVE_PORT="${HIVE_PORT:-HIVEPORT}"

export HIVE_DB_NAME="${HIVE_DB_NAME:-HIVEDBNAME}"

# PostgreSQL Configurations - Used when Postgres is supporting the Hive Metastore
# POSTGRES_HOME is the location of the PostgreSQL binaries
export POSTGRES_HOME="${POSTGRES_HOME:-POSTGRESHOME}"
# PGPORT is the port that PostgreSQL will listen for connections on (default is 11115)
export PGPORT=${PGPORT:-POSTGRESPORT}
# PGDATA is the path to the PostgreSQL database.  MUST NOT HAVE *ANY* GROUP PERMISSIONS
export PGDATA="${PGDATA:-POSTGRESDATA}"

