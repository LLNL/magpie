#!/bin/sh
#############################################################################
#  Copyright (C) 2013-2015 Lawrence Livermore National Security, LLC.
#  Produced at Lawrence Livermore National Laboratory (cf, DISCLAIMER).
#  Written by Albert Chu <chu11@llnl.gov>
#  LLNL-CODE-644248
#
#  This file is part of Magpie, scripts for running Hadoop on
#  traditional HPC systems.  For details, see https://github.com/llnl/magpie.
#
#  Magpie is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  Magpie is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Magpie.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

############################################################################
# LSF Customizations
############################################################################

# Node count.  Node count should include one node for the
# head/management/master node.  For example, if you want 8 compute
# nodes to process data, specify 9 nodes below.
#
# If including Zookeeper, include expected Zookeeper nodes.  For
# example, if you want 8 Hadoop compute nodes and 3 Zookeeper nodes,
# specify 12 nodes (1 master, 8 Hadoop, 3 Zookeeper)
#
# Also take into account additional nodes needed for other services,
# for example HDFS federation.

#BSUB -n <my node count>
#BSUB -o "lsf-%J.out"

# Note defaults of MAGPIE_STARTUP_TIME & MAGPIE_SHUTDOWN_TIME, this
# timelimit should be a fair amount larger than them combined.
#BSUB -W <my time in hours:minutes>

# Job name.  This will be used in naming directories for the job.
#BSUB -J <my job name>

# Queue to launch job in
#BSUB -q <my queue>

## LSF Values
# Generally speaking, don't touch the following, misc other configuration

#BSUB -R "span[ptile=1]"
#BSUB -x

# Need to tell Magpie how you are submitting this job
export MAGPIE_SUBMISSION_TYPE="lsfmpirun"

############################################################################
# Magpie Configurations
############################################################################

# Directory your launching scripts/files are stored
#
# Normally an NFS mount, someplace magpie can be reached on all nodes.
export MAGPIE_SCRIPTS_HOME="${HOME}/magpie"

# Path to store data local to each cluster node, typically something
# in /tmp.  This will store local conf files and log files for your
# job.  If local scratch space is not available, consider using the
# MAGPIE_NO_LOCAL_DIR option.  See README for more details.
#
export MAGPIE_LOCAL_DIR="/tmp/${USER}/magpie"

# Magpie job type
#
# "hbase" - Run a job according to the settings of HBASE_MODE.
#
# "zookeeper" - Run a job according to the settings of ZOOKEEPER_MODE.
#
# "testall" - Run a job that runs all basic sanity tests for all
#             software that is configured to be setup.  This is a good
#             way to sanity check that everything has been setup
#             correctly and the way you like.
#
#             For Hbase, testall will run performanceeval
#             For Zookeeper, testall will run zookeeperruok
#
# "script" - Run an arbitraty script, as specified by
#            MAGPIE_SCRIPT_PATH.  This functionally is very similar to
#            setting "script" in HADOOP_MODE or HBASE_MODE or
#            SPARK_MODE.
#
#            It is primarily used if you want to launch without
#            Hadoop/Hbase/Spark and are experimenting with things..
#
# "interactive" - manually interact with job run.  This functionally
#                 is very similar to setting "interactive" in
#                 HADOOP_MODE, HBASE_MODE, SPARK_MODE, etc.  It is
#                 primarily used if you want to launch without
#                 Hadoop/Hbase/Spark/etc. and are experimenting with
#                 things.
#
export MAGPIE_JOB_TYPE="hbase"

# Specify script to execute for "script" mode in MAGPIE_JOB_TYPE
#
# export MAGPIE_SCRIPT_PATH="${HOME}/my-job-script"

# Specify arguments for script specified in MAGPIE_SCRIPT_PATH
#
# Note that many Magpie generated environment variables are not
# generated until the job has launched.  You won't be able to use them
# here.
#
# export MAGPIE_SCRIPT_ARGS="" 

# Specify script startup / shutdown time window
#
# Specifies the amount of time to give startup / shutdown activities a
# chance to succeed before Magpie will give up (or in the case of
# shutdown, when the resource manager/scheduler may kill the running
# job).  Defaults to 30 minutes for startup, 30 minutes for shutdown.
#
# The startup time in particular may need to be increased if you have
# a large amount of data.  As an example, HDFS may need to spend a
# significant amount of time determine all of the blocks in HDFS
# before leaving safemode.
#
# The stop time in particular may need to be increased if you have a
# large amount of cleanup to be done.  HDFS will save its NameSpace
# before shutting down.  Hbase will do a compaction before shutting
# down.
#
# The startup & shutdown window must together be smaller than the
# SBATCH_TIMELIMIT specified above.
#
# MAGPIE_STARTUP_TIME and MAGPIE_SHUTDOWN_TIME at minimum must be 5
# minutes.  If MAGPIE_POST_JOB_RUN is specified below,
# MAGPIE_SHUTDOWN_TIME must be at minimum 10 minutes.
#
# export MAGPIE_STARTUP_TIME=30
# export MAGPIE_SHUTDOWN_TIME=30

# Convenience Scripts
#
# Specify script to be executed to before / after your job.  It is run
# on all nodes.
#
# Typically the pre-job script is used to set something up or get
# debugging info.  It can also be used to determine if system
# conditions meet the expectations of your job.  The primary job
# running script (magpie-run) will not be executed if the
# MAGPIE_PRE_JOB_RUN exits with a non-zero exit code.
#
# The post-job script is typically used for cleaning up something or
# gathering info (such as logs) for post-debugging/analysis.  If it is
# set, MAGPIE_SHUTDOWN_TIME above must be > 5.
#
# See example magpie-example-pre-job-script and
# magpie-example-post-job-script for ideas of what you can do w/ these
# scripts
#
# A number of convenient scripts are available in the
# ${MAGPIE_SCRIPTS_HOME}/scripts directory.
#
# export MAGPIE_PRE_JOB_RUN="${MAGPIE_SCRIPTS_HOME}/scripts/pre-job-run-scripts/my-pre-job-script"
# export MAGPIE_POST_JOB_RUN="${MAGPIE_SCRIPTS_HOME}/scripts/post-job-run-scripts/my-post-job-script"

# Environment Variable Script
#
# When working with Magpie interactively by logging into the master
# node of your job allocation, many environment variables may need to
# be set.  For example, environment variables for config file
# directories (e.g. HADOOP_CONF_DIR, HBASE_CONF_DIR, etc.) and home
# directories (e.g. HADOOP_HOME, HBASE_HOME, etc.) and more general
# environment variables (e.g. JAVA_HOME) may need to be set before you
# begin interacting with your big data setup.
#
# The standard job output from Magpie provides instructions on all the
# environment variables typically needed to interact with your job.
# However, this can be tedious if done by hand.
#
# If the environment variable specified below is set, Magpie will
# create the file and put into it every environment variable that
# would be useful when running your job interactively.  That way, it
# can be sourced easily if you will be running your job interactively.
# It can also be loaded or used by other job scripts.
#
# export MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT="${HOME}/my-job-env"

# Environment Variable Shell Type
#
# Magpie outputs environment variables in help output and
# MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT based on your SHELL environment
# variable.
#
# If you would like to output in a different shell type (perhaps you
# have programmed scripts in a different shell), specify that shell
# here.
#
# export MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT_SHELL="/bin/bash"

# Remote Shell
#
# Magpie requires a passwordless remote shell command to launch
# necessary daemons across your job allocation.  Magpie defaults to
# ssh, but it may be an alternate command in some environments.  An
# alternate ssh-equivalent remote command can be specified by setting
# MAGPIE_REMOTE_CMD below.
#
# If using ssh, Magpie requires keys to be setup ahead of time so it
# can be executed without passwords.
#
# Specify options to the remote shell command if necessary.
#
# export MAGPIE_REMOTE_CMD="ssh"
# export MAGPIE_REMOTE_CMD_OPTS=""

############################################################################
# General Configuration
############################################################################

# Necessary for most projects
export JAVA_HOME="/usr/lib/jvm/jre-1.7.0-oracle.x86_64/"

############################################################################
# Hadoop Core Configurations
############################################################################

# Should Hadoop be run
#
# Specify yes or no.  Defaults to no.
#
export HADOOP_SETUP=yes

# Set Hadoop Setup Type
#
# Will inform scripts on how to setup config files and what daemons to
# launch/setup.  The hadoop build/binaries set by HADOOP_HOME
# needs to match up with what you set here.
#
# MR1 - MapReduce/Hadoop 1.0 w/ HDFS
# MR2 - MapReduce/Hadoop 2.0 w/ HDFS
# HDFS1 - HDFS only w/ Hadoop 1.0
# HDFS2 - HDFS only w/ Hadoop 2.0
#
# The HDFS only options may be useful when you want to use HDFS with
# other big data software, such as Hbase, and do not care for using
# Hadoop MapReduce.  It only works with HDFS based
# HADOOP_FILESYSTEM_MODE, such as "hdfs", "hdfsoverlustre", or
# "hdfsovernetworkfs".
#
export HADOOP_SETUP_TYPE="HDFS2"

# Version
#
# Make sure the version for Mapreduce version 1 or 2 matches whatever
# you set in HADOOP_SETUP_TYPE
#
export HADOOP_VERSION="2.8.0"

# Path to your Hadoop build/binaries
#
# Make sure the build for MapReduce or HDFS version 1 or 2 matches
# whatever you set in HADOOP_SETUP_TYPE.
#
# This should be accessible on all nodes in your allocation. Typically
# this is in an NFS mount.
#
export HADOOP_HOME="${HOME}/hadoop-${HADOOP_VERSION}"

# Path to store data local to each cluster node, typically something
# in /tmp.  This will store local conf files and log files for your
# job.  If local scratch space is not available, consider using the
# MAGPIE_NO_LOCAL_DIR option.  See README for more details.
#
# This will not be used for storing intermediate files or
# distributed cache files.  See HADOOP_LOCALSTORE above for that.
#
export HADOOP_LOCAL_DIR="/tmp/${USER}/hadoop"

# Directory where alternate Hadoop configuration templates are stored
#
# If you wish to tweak the configuration files used by Magpie, set
# HADOOP_CONF_FILES below, copy configuration templates from
# $MAGPIE_SCRIPTS_HOME/conf/hadoop into HADOOP_CONF_FILES, and modify
# as you desire.  Magpie will still use configuration files in
# $MAGPIE_SCRIPTS_HOME/conf/hadoop if of the files it needs are not
# found in HADOOP_CONF_FILES.
#
# export HADOOP_CONF_FILES="${HOME}/myconf"

# Daemon Heap Max
#
# Heap maximum for Hadoop daemons (i.e. Resource Manger, NodeManager,
# DataNode, History Server, etc.), specified in megs.  Special case
# for Namenode, see below.
#
# If not specified, defaults to Hadoop default of 1000
#
# May need to be increased if you are scaling large, get OutofMemory
# errors, or perhaps have a lot of cores on a node.
#
# export HADOOP_DAEMON_HEAP_MAX=2000

# Daemon Namenode Heap Max
#
# Heap maximum for Hadoop Namenode daemons specified in megs.
#
# If not specified, defaults to HADOOP_DAEMON_HEAP_MAX above.
#
# Unlike most Hadoop daemons, namenode may need more memory if there
# are a very large number of files in your HDFS setup.  A general rule
# of thumb is a 1G heap for each 100T of data.
#
# export HADOOP_NAMENODE_DAEMON_HEAP_MAX=2000

# Environment Extra
#
# Specify extra environment information that should be passed into
# Hadoop.  This file will simply be appended into the hadoop-env.sh
# and (if appropriate) yarn-env.sh.
#
# By default, a reasonable estimate for max user processes and open
# file descriptors will be calculated and put into hadoop-env.sh and
# (if appropriate) yarn-env.sh.  However, it's always possible they may
# need to be set differently. Everyone's cluster/situation can be
# slightly different.
#
# See the example example-environment-extra extra for examples on
# what you can/should do with adding extra environment settings.
#
# export HADOOP_ENVIRONMENT_EXTRA_PATH="${HOME}/hadoop-my-environment"

############################################################################
# Hadoop Job/Run Configurations
############################################################################

# Set how Hadoop should run
#
# "terasort" - run terasort.  Useful for making sure things are setup
#              the way you like.
#
#              There are additional configuration options for this
#              listed below.
#
# "script" - execute a script that lists all of your Hadoop jobs.  Be
#            sure to set HADOOP_SCRIPT_PATH to your script.
#
# "interactive" - manually interact to submit jobs, peruse HDFS, etc.
#                 also useful for moving data in/out of HDFS.  In this
#                 mode you'll login to the cluster node that is your
#                 'master' node and interact with Hadoop directly
#                 (e.g. bin/hadoop ...)
#
# "upgradehdfs" - upgrade your version of HDFS.  Most notably this is
#                 used when you are switching to a newer Hadoop
#                 version and the HDFS version would be inconsistent
#                 without upgrading.  Only works with HDFS versions >=
#                 2.2.0.
#
#	          Please set your job time to be quite large when
#		  performing this upgrade.  If your job times out and
#		  this process does not complete fully, it can leave
#		  HDFS in a bad state.
#
#		  Beware, once you upgrade it'll be difficult to rollback.
#
# "decommissionhdfsnodes" - decrease your HDFS over Lustre or HDFS
#                           over NetworkFS node size just as if you
#                           were on a cluster with local disk.  Launch
#                           your job with the current present node
#                           size and set
#                           HADOOP_DECOMMISSION_HDFS_NODE_SIZE to the
#                           smaller node size to decommission into.
#                           Only works on Hadoop versions >= 2.3.0.
#
#		            Please set your job time to be quite large
#		            when performing this update.  If your job
#		            times out and this process does not
#		            complete fully, it can leave HDFS in a bad
#		            state.
#
# "launch" - Launch Hadoop but do nothing, usually set to this because
#            another project (e.g. Hbase, Pig) will run something that
#            uses Hadoop MapReduce.
#
# "setuponly" - Like 'interactive' but only setup conf files. useful
#               if user wants to setup & teardown daemons themselves.
#
# "hdfsonly" - For use if HADOOP_SETUP_TYPE is set to HDFS1 or HDFS2.
#
export HADOOP_MODE="hdfsonly"

############################################################################
# Hadoop Filesystem Mode Configurations
############################################################################

# Set how the filesystem should be setup
#
# "hdfs" - Normal straight up HDFS if you have local disk in your
#          cluster.  This option is primarily for benchmarking and
#          caching, but probably shouldn't be used in the general case.
#
#          Be careful running this in a cluster environment.  The next
#          time you execute your job, if a different set of nodes are
#          allocated to you, the HDFS data you wrote from a previous
#          job may not be there.  Specifying specific nodes to use in
#          your job submission (e.g. --nodelist in sbatch) may be a
#          way to alleviate this.
#
#          User must set HADOOP_HDFS_PATH below.
#
# "hdfsoverlustre" - HDFS over Lustre.  See README for description.
#
#                    User must set HADOOP_HDFSOVERLUSTRE_PATH below.
#
# "hdfsovernetworkfs" - HDFS over Network FS.  Identical to HDFS over
#                       Lustre, but filesystem agnostic.
#
#                       User must set HADOOP_HDFSOVERNETWORKFS_PATH below.
#
# "rawnetworkfs" - Use Hadoop RawLocalFileSystem (i.e. file: scheme),
#           to use networked file system directly.  It could be a
#           Lustre mount or NFS mount.  Whatever you please.
#
#           User must set HADOOP_RAWNETWORKFS_PATH below.
#
export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"

# HDFS Replication
#
# This is used with HADOOP_FILESYSTEM_MODE="hdfs", "hdfsoverlustre",
# and "hdfsovernetworkfs"
#
# HDFS commonly uses 3.  When doing HDFS over Lustre/NetworkFS, higher
# replication can also help with resilience if nodes fail.  You may
# wish to set this to < 3 to save space.
#
# If not specified, defaults to 3
#
# export HADOOP_HDFS_REPLICATION=3

# Path for HDFS when using local disk
#
# This is used with HADOOP_FILESYSTEM_MODE="hdfs"
#
# If you want to specify multiple paths (such as multiple drives),
# make them comma separated (e.g. /dir1,/dir2,/dir3).  The multiple
# paths will be used for local intermediate data and HDFS.  The first
# path will also store daemon data, such as namenode or jobtracker
# data.
#
export HADOOP_HDFS_PATH="/ssd/${USER}/hdfs"

# HDFS cleanup
#
# After your job has completed, if HADOOP_HDFS_PATH_CLEAR is set to
# yes, Magpie will do a rm -rf on HADOOP_HDFS_PATH.  
#
# This is particularly useful when doing normal HDFS on local storage.
# On your next job run, you may not be able to get the nodes you want
# on your next run.  So you may want to clean up your work before the
# next user uses the node.
#
# export HADOOP_HDFS_PATH_CLEAR="yes"

# HDFS Block Size
#
# Commonly 134217728, 268435456, 536870912 (i.e. 128m, 256m, 512m)
#
# If not specified, defaults to 134217728
#
# export HADOOP_HDFS_BLOCKSIZE=134217728

# Lustre path to do Hadoop HDFS out of
#
# This is used with HADOOP_FILESYSTEM_MODE="hdfsoverlustre"
#
# Note that different versions of Hadoop may not be compatible with
# your current HDFS data.  If you're going to switch around to
# different versions, perhaps set different paths for different data.
#
export HADOOP_HDFSOVERLUSTRE_PATH="/lustre/${USER}/hdfsoverlustre/"

# HDFS over Lustre ignore lock
#
# Cleanup in_use.lock files before launching HDFS
#
# On traditional Hadoop clusters, the in_use.lock file protects
# against a second HDFS daemon running on the same node.  The lock
# file can similarly protect against a second HDFS daemon running on
# another node of your cluster (which is not desired, as both
# namenodes could change namenode data at the same time).
#
# However, sometimes the lock file may be there due to a prior job
# that failed and locks were not cleaned up on teardown.  This may
# prohibit new HDFS daemons from running correctly.
#
# By default, if this option is not set, the lock file will be left in
# place and may cause HDFS daemons to not start.  If set to yes, the
# lock files will be removed before starting HDFS.
#
# export HADOOP_HDFSOVERLUSTRE_REMOVE_LOCKS=yes

# Networkfs path to do Hadoop HDFS out of
#
# This is used with HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"
#
# Note that different versions of Hadoop may not be compatible with
# your current HDFS data.  If you're going to switch around to
# different versions, perhaps set different paths for different data.
#
export HADOOP_HDFSOVERNETWORKFS_PATH="/networkfs/${USER}/hdfsovernetworkfs/"

# HDFS over Networkfs ignore lock
#
# Cleanup in_use.lock files before launching HDFS
#
# On traditional Hadoop clusters, the in_use.lock file protects
# against a second HDFS daemon running on the same node.  The lock
# file can similarly protect against a second HDFS daemon running on
# another node of your cluster (which is not desired, as both
# namenodes could change namenode data at the same time).
#
# However, sometimes the lock file may be there due to a prior job
# that failed and locks were not cleaned up on teardown.  This may
# prohibit new HDFS daemons from running correctly.
#
# By default, if this option is not set, the lock file will be left in
# place and may cause HDFS daemons to not start.  If set to yes, the
# lock files will be removed before starting HDFS.
#
# export HADOOP_HDFSOVERNETWORKFS_REMOVE_LOCKS=yes

# Path for rawnetworkfs
#
# This is used with HADOOP_FILESYSTEM_MODE="rawnetworkfs"
#
export HADOOP_RAWNETWORKFS_PATH="/lustre/${USER}/rawnetworkfs/"

# RawNetworkFS Block Size
#
# Commonly 33554432, 67108864, 134217728 (i.e. 32m, 64m, 128m)
#
# If not specified, defaults to 33554432
#
# export HADOOP_RAWNETWORKFS_BLOCKSIZE=33554432

# If you have a local SSD or NVRAM, performance may be better to store
# intermediate data on it rather than Lustre or some other networked
# filesystem.  If the below environment variable is specified, local
# intermediate data will be stored in the specified directory.
# Otherwise it will go to an appropriate directory in Lustre/networked
# FS.
#
# Be wary, local SSDs/NVRAM stores may have less space than HDDs or
# networked file systems.  It can be easy to run out of space.
#
# If you want to specify multiple paths (such as multiple drives),
# make them comma separated (e.g. /dir1,/dir2,/dir3).  The multiple
# paths will be used for local intermediate data.
#
# export HADOOP_LOCALSTORE="/ssd/${USER}/localstore/"

# HADOOP_LOCALSTORE_CLEAR 
#
# After your job has completed, if HADOOP_LOCALSTORE_CLEAR is set to
# yes, Magpie will do a rm -rf on all directories in
# HADOOP_LOCALSTORE.  This is particularly useful if the localstore
# directory is on local storage and you want to clean up your work
# before the next user uses the node.
#
# export HADOOP_LOCALSTORE_CLEAR="yes"

# Option to use unique locations per job to store hdfs data
#
# If this is set to yes the nodes will append the job id to the
# current HDFSOVERLUSTRE and HDFSOVERNETWORKFS path thus keeping the
# hdfs data isolated per job. This enables the same script to be
# executed multiple times (usually with different data) without the
# HDFSOVERXXX instances colliding with each other
#
# Be careful to cleanup the HDFSOVERXXX directories from time to time,
# as Magpie will not clear data from prior jobs.
#
# export HADOOP_PER_JOB_HDFS_PATH="yes"

############################################################################
# Hadoop Script Configurations
############################################################################

# Specify script to execute for "script" mode
#
# See examples/hadoop-example-job-script for example of what to put in
# the script.
#
# export HADOOP_SCRIPT_PATH="${HOME}/my-job-script"

# Specify arguments for script specified in HADOOP_SCRIPT_PATH
#
# Note that many Magpie generated environment variables, such as
# HADOOP_MASTER_NODE, are not generated until the job has launched.
# You won't be able to use them here.
#
# export HADOOP_SCRIPT_ARGS="" 

############################################################################
# Hadoop Decommission HDFS Nodes Configurations
############################################################################

# Specify decommission node size for "decommissionhdfsnodes" mode
#
# For example, if your current HDFS node size is 16, your job size is
# likely 17 nodes (including the master).  If you wish to decommission
# to 8 data nodes (job size of 9 nodes total), set this to 8.
#
# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8

############################################################################
# Hbase Core Configurations
############################################################################

# Should Hbase be run
#
# Specify yes or no.  Defaults to no.
#
export HBASE_SETUP=yes

# Version
#
export HBASE_VERSION="1.3.1"

# Path to your Hbase build/binaries
#
# This should be accessible on all nodes in your allocation. Typically
# this is in an NFS mount.
#
# Ensure the build matches the Hadoop/HDFS version this will run against.
#
export HBASE_HOME="${HOME}/hbase-${HBASE_VERSION}"

# Path to store data local to each cluster node, typically something
# in /tmp.  This will store local conf files and log files for your
# job.  If local scratch space is not available, consider using the
# MAGPIE_NO_LOCAL_DIR_DIR option.  See README for more details.
#
export HBASE_LOCAL_DIR="/tmp/${USER}/hbase"

# Directory where alternate Hbase configuration templates are stored
#
# If you wish to tweak the configuration files used by Magpie, set
# HBASE_CONF_FILES below, copy configuration templates from
# $MAGPIE_SCRIPTS_HOME/conf/hbase into HBASE_CONF_FILES, and modify as
# you desire.  Magpie will still use configuration files in
# $MAGPIE_SCRIPTS_HOME/conf/hbase if of the files it needs are not
# found in HBASE_CONF_FILES.
#
# export HBASE_CONF_FILES="${HOME}/myconf"

# Master Daemon Heap Max
#
# Heap size for Hbase master daemons, specified in megs.
#
# If not specified, defaults to 1000
#
# export HBASE_MASTER_DAEMON_HEAP_MAX=1000

# Regionserver Daemon Heap Max
#
# Heap size for Hbase regionserver daemons, specified in megs.
#
# If not specified, defaults to 16000, or 50% of system memory,
# whichever is smaller.
#
# export HBASE_REGIONSERVER_DAEMON_HEAP_MAX=16000

# Environment Extra
#
# Specify extra environment information that should be passed into
# Hbase.  This file will simply be appended into the hbase-env.sh.
#
# By default, a reasonable estimate for max user processes and open
# file descriptors will be calculated and put into hbase-env.sh.
# However, it's always possible they may need to be set
# differently. Everyone's cluster/situation can be slightly different.
#
# See the example example-environment-extra for examples on
# what you can/should do with adding extra environment settings.
#
# export HBASE_ENVIRONMENT_EXTRA_PATH="${HOME}/hbase-my-environment"

############################################################################
# Hbase Job/Run Configurations
############################################################################

# Set how Hbase should run
#
# "performanceeval" - run performance evaluation write and read.
#              Useful for making sure things are setup the way you
#              like.
#
#              There are additional configuration options for this
#              listed below.
#
# "script" - execute a script that lists all of your Hbase jobs.  Be
#            sure to set HBASE_SCRIPT_PATH to your script.
#
# "interactive" - manually interact to submit jobs, peruse Hbase, etc.
#                 In this mode you'll login to the cluster node that
#                 is your 'master' node and interact with Hbase
#                 directly (e.g. bin/hbase ...)
#
# "setuponly" - Like 'interactive' but only setup conf files. useful
#               if user wants to setup & teardown daemons themselves.
#
export HBASE_MODE="performanceeval"

# Start Hbase with thrift
#
# This will start up thrift alongside of Hbase master
# Defaults to 'no'
#
# export HBASE_START_THRIFT_SERVER="no"

# Should a major compaction be done when Hbase is being shut down.  In
# general, this is something that should be done to compact small
# files, remove flagged deletes, etc., but could take a long time.
# MAGPIE_SHUTDOWN_TIME should be large enough to handle this.
#
# This can also be run via the convenience script
# hbase-major-compaction.sh.
#
# Specify yes or no.  Defaults to yes.
# export HBASE_MAJOR_COMPACTION_ON_SHUTDOWN=yes

############################################################################
# Hbase Performance Evaluation Configurations
############################################################################

# Performance Evaluation Mode
#
# Specify 'sequential-thread' for threaded sequential write/read
# Specify 'sequential-mr' for MapReduce sequential write/read
# Specify 'random-thread' for threaded random write/read
# Specify 'random-mr' for MapReduce random write/read
#
# Defaults to 'sequential-thread' if not specified.
#
# export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"

# Performance Evaluation Rows
#
# For "performanceeval" mode.  Rows each client will run.
#
# Defaults to 1048576 (~1 million)
#
# export HBASE_PERFORMANCEEVAL_ROW_COUNT=1048576

# Performance Evaluation client count
#
# For "performanceeval" mode.
#
# If not specified, defaults to 1.
#
# export HBASE_PERFORMANCEEVAL_CLIENT_COUNT=1

############################################################################
# Hbase Script Configurations
############################################################################

# Specify script to execute for "script" mode
#
# See examples/hbase-example-job-script for example of what to put in
# the script.
#
# export HBASE_SCRIPT_PATH="${HOME}/my-job-script"

# Specify arguments for script specified in HBASE_SCRIPT_PATH
#
# Note that many Magpie generated environment variables, such as
# HBASE_MASTER_NODE, are not generated until the job has launched.
# You won't be able to use them here.
#
# export HBASE_SCRIPT_ARGS="" 
 
############################################################################
# Zookeeper Configurations
############################################################################

# Should Zookeeper be run
#
# Specify yes or no.  Defaults to no.
#
export ZOOKEEPER_SETUP=yes

# Zookeeper Replication Count
#
# Recommended to be odd.
#
export ZOOKEEPER_REPLICATION_COUNT=3

# Zookeeper Node Sharing
#
# By default, Zookeeper will not run on nodes that will run Hadoop/Hbase.
# They will have dedicated nodes for themselves.  If you do not wish
# for this to be the case, set the below to 'yes'.  Defaults to no.
#
# Keep in mind that adjustments to the number of nodes in your
# allocation may need to be adjusted given your setting of this
# parameter.  For example, if you want 8 nodes for Hadoop processing,
# you should increase your allocation by ZOOKEEPER_REPLICATION_COUNT
# if the below is 'no'.
#
# export ZOOKEEPER_SHARE_NODES=yes

# Set how Zookeeper should run
#
# "zookeeperruok" - Run a quick sanity test to see that zookeeper is
#             setup correctly.  zookeeperruok will do a simple 'ruok'
#             to all Zookeeper daemons.
#
# "launch" - Magpie will launch Zookeeper daemons
#
# "setuponly" - Like 'launch' but only setup conf files. useful
#               if user wants to setup & teardown daemons themselves.
#
export ZOOKEEPER_MODE="launch"

# Zookeeper Version
#
export ZOOKEEPER_VERSION="3.4.9"

# Path to your Zookeeper build/binaries
#
# This should be accessible on all nodes in your allocation. Typically
# this is in an NFS mount.
#
export ZOOKEEPER_HOME="${HOME}/zookeeper-${ZOOKEEPER_VERSION}"

# Directory where alternate Zookeeper configuration templates are stored
#
# If you wish to tweak the configuration files used by Magpie, set
# ZOOKEEPER_CONF_FILES below, copy configuration templates from
# $MAGPIE_SCRIPTS_HOME/conf/zookeeper into ZOOKEEPER_CONF_FILES, and
# modify as you desire.  Magpie will still use configuration files in
# $MAGPIE_SCRIPTS_HOME/conf/zookeeper if of the files it needs are not
# found in ZOOKEEPER_CONF_FILES.
#
# export ZOOKEEPER_CONF_FILES="${HOME}/myconf"

# Path base for zookeeper data to be stored on each cluster node
#
# ZOOKEEPER_DATA_DIR can point to either a network file system path or
# a local drive path.
#
# If a local drive or SSD/NVRAM is available, a local path is
# preferable.  If set to local, please see ZOOKEEPER_DATA_DIR_TYPE
# below for optimization possibilties.
#
export ZOOKEEPER_DATA_DIR="/lustre/${USER}/zookeeper"

# Zookeeper cleanup
#
# After your job has completed, if ZOOKEEPER_DATA_DIR_CLEAR is set to
# yes, Magpie will do a rm -rf on ZOOKEEPER_DATA_DIR.  This may be
# convenient for cleaning up your job after it has run.  This is
# particularly useful if ZOOKEEPER_DATA_DIR is on a local ssd /drive.
# B/c on your next job run, you may not be able to get the nodes you
# want on your next run, leading to problems.
#
# export ZOOKEEPER_DATA_DIR_CLEAR="yes"

# Zookeeper data dir type
#
# Inform Magpie what type of directory ZOOKEEPER_DATA_DIR points to.
#
# This configuration isn't entirely necessary to be set, but if set to
# networkfs, Magpie will increase a number of default timeouts in
# Zookeeper as well as other projects to adjust for the fact Zookeeper
# is running on a network file system.
#
# "networkfs" - ZOOKEEPER_DATA_DIR points to a network filesystem
#               (such as Lustre).
#
# "local" - ZOOKEEPER_DATA_DIR points to a local drive.
#
export ZOOKEEPER_DATA_DIR_TYPE="networkfs"

# Path to store data local to each cluster node, typically something
# in /tmp.  This will store local conf files and log files for your
# job.  If local scratch space is not available, consider using the
# MAGPIE_NO_LOCAL_DIR_DIR option.  See README for more details.
#
export ZOOKEEPER_LOCAL_DIR="/tmp/${USER}/zookeeper"

# Option to have per job data dir
#
# For each batch job, if this is set to yes, the location where
# zookeeper stores its data dir will be unique per job. The data
# dir will have the job id appended to the path to keep them organized.
# It will allows for multiple instances of the same script to be run
# without having collisions due to different nodes being used.
#
# export ZOOKEEPER_PER_JOB_DATA_DIR="yes"

# ZooKeeper ticktime, measured in milliseconds.  Used by all of
# Zookeeper for time measurement.
#
# Defaults to 2000.
#
# export ZOOKEEPER_TICKTIME=2000

# ZooKeeper initLimit, multiple of ticks to allow followers to connect
# and sync to a leader.  May need to increase this value if the data
# managed by ZooKeeper is large.
#
# Defaults to 10 if ZOOKEEPER_DATA_DIR_TYPE is local, 20 if networkfs
#
# export ZOOKEEPER_INITLIMIT=10

# ZooKeeper syncLimit, multiple of ticks to allow followers to sync
# with ZooKeeper.  If they fall too far behind a leader, they will be
# dropped.
#
# Defaults to 5 if ZOOKEEPER_DATA_DIR_TYPE is local, 10 if networkfs
#
# export ZOOKEEPER_SYNCLIMIT=5

############################################################################
# Run Job
############################################################################

# Set alternate mpirun options here
# MPIRUN_OPTIONS="-genvall -genv MV2_USE_APM 0"

mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-check-inputs
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-setup-core
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-setup-projects
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-setup-post
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-pre-run
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-run
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-cleanup
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-post-run
