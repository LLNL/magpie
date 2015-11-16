#!/bin/sh
#############################################################################
#  Copyright (C) 2013-2015 Lawrence Livermore National Security, LLC.
#  Produced at Lawrence Livermore National Laboratory (cf, DISCLAIMER).
#  Written by Albert Chu <chu11@llnl.gov>
#  LLNL-CODE-644248
#  
#  This file is part of Magpie, scripts for running Hadoop on
#  traditional HPC systems.  For details, see https://github.com/chu11/magpie.
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
# Generally speaking, don't touch these, just need to configure slurm

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
# "hadoop" - Run a job according to the settings of HADOOP_MODE.
#
# "hbase" - Run a job according to the settings of HBASE_MODE.
#
# "phoenix" - Run a job according to the settings of PHOENIX_MODE
#
# "pig" - Run a job according to the settings of PIG_MODE.
#
# "mahout" - Run a job according to the settings of MAHOUT_MODE.
#
# "spark" - Run a job according to the settings of SPARK_MODE.
#
# "storm" - Run a job according to the settings of STORM_MODE.
#
# "tachyon" - Run a job according ot the settings of TACHYON_MODE. 
#
# "zookeeper" - Run a job according to the settings of ZOOKEEPER_MODE.
#
# "testall" - Run a job that runs all basic sanity tests for all
#             software that is configured to be setup.  This is a good
#             way to sanity check that everything has been setup
#             correctly and the way you like.
#
#             For Hadoop, testall will run terasort
#             For Hbase, testall will run performanceeval
#             For Phoenix, testall will run performanceeval
#             For Pig, testall will run testpig
#             For Mahout, testall will run clustersyntheticcontrol
#             For Spark, testall will run sparkpi
#             For Storm, testall will run stormwordcount
#             For tachyon, testall will run testtachyon
#             For Zookeeper, testall will run zookeeperruok
#
# "script" - Run an arbitraty script, as specified by
#            MAGPIE_SCRIPT_PATH.  This functionally is very similar to
#            setting "script" in HADOOP_MODE or HBASE_MODE or
#            SPARK_MODE or STORM_MODE.
#
#            It is primarily used if you want to launch without
#            Hadoop/Hbase/Spark/Storm (such as Zookeeper only) and are
#            experimenting with things..
#
# "interactive" - manually interact with job run.  This functionally
#                 is very similar to setting "interactive" in
#                 HADOOP_MODE, HBASE_MODE, SPARK_MODE, STORM_MODE, or
#                 PIG_MODE.  It is primarily used if you want to
#                 launch without Hadoop/Hbase/Spark/Storm (such as
#                 Zookeeper only) and are experimenting with things..
#
export MAGPIE_JOB_TYPE="pig"

# Specify script to execute for "script" mode in MAGPIE_JOB_TYPE
#
# export MAGPIE_SCRIPT_PATH="${HOME}/my-job-script"

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
# A number of convenient scripts are available in the scripts
# directory.
#
# export MAGPIE_PRE_JOB_RUN="${HOME}/magpie-my-pre-job-script"
# export MAGPIE_POST_JOB_RUN="${HOME}/magpie-my-post-job-script"

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

# Necessary for Hadoop, Hbase, Pig, and Zookeeper
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
export HADOOP_SETUP_TYPE="MR2"

# Version
#
# Make sure the version for Mapreduce version 1 or 2 matches whatever
# you set in HADOOP_SETUP_TYPE
#
export HADOOP_VERSION="2.7.1"

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

# Directory where Hadoop configuration templates are stored
#
# If not specified, assumed to be $MAGPIE_SCRIPTS_HOME/conf
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
# (and if appropriate) yarn-env.sh.
#
# By default, a reasonable estimate for max user processes and open
# file descriptors will be calculated and put into hadoop-env.sh (and
# if appropriate) yarn-env.sh.  However, it's always possible they may
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
#              example listed below.
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
#		  Beware, once you upgrade it'll be difficult to rollback.
#
# "launch" - Launch Hadoop but do nothing, usually set to this because
#            another project (e.g. Hbase, Pig) will run something that
#            uses Hadoop MapReduce.
#
# "setuponly" - Like 'interactive' but only setup conf files. useful
#               if user wants to setup daemons themselves, etc.
#
# "hdfsonly" - For use if HADOOP_SETUP_TYPE is set to HDFS1 or HDFS2. 
#
export HADOOP_MODE="launch"

# Tasks per Node
#
# If not specified, a reasonable estimate will be calculated based on
# number of CPUs on the system.
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_MAX_TASKS_PER_NODE=8

# Default Map tasks for Job
#
# If not specified, defaults to HADOOP_MAX_TASKS_PER_NODE * compute
# nodes.
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_DEFAULT_MAP_TASKS=8

# Default Reduce tasks for Job
#
# If not specified, defaults to # compute nodes (i.e. 1 reducer per
# node)
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_DEFAULT_REDUCE_TASKS=8

# Max Map tasks for Task Tracker
#
# If not specified, defaults to HADOOP_MAX_TASKS_PER_NODE
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_MAX_MAP_TASKS=8

# Max Reduce tasks for Task Tracker
#
# If not specified, defaults to HADOOP_MAX_TASKS_PER_NODE
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_MAX_REDUCE_TASKS=8

# Heap size for JVM 
#
# Specified in M.  If not specified, a reasonable estimate will be
# calculated based on total memory available and number of CPUs on the
# system.
#
# HADOOP_CHILD_MAP_HEAPSIZE and HADOOP_CHILD_REDUCE_HEAPSIZE are for
# Yarn (i.e. HADOOP_SETUP_TYPE = MR2)
#
# If HADOOP_CHILD_MAP_HEAPSIZE is not specified, it is assumed to be
# HADOOP_CHILD_HEAPSIZE.
#
# If HADOOP_CHILD_REDUCE_HEAPSIZE is not specified, it is assumed to
# be 2X the HADOOP_CHILD_MAP_HEAPSIZE.
#
# If running Hbase (or other Big Data software) with Hadoop MapReduce,
# be aware of the number of tasks and the amount of memory that may be
# needed by other software.
#
# export HADOOP_CHILD_HEAPSIZE=2048
# export HADOOP_CHILD_MAP_HEAPSIZE=2048
# export HADOOP_CHILD_REDUCE_HEAPSIZE=4096

# Container Buffer
#
# Specify the amount of overhead each Yarn container will have over
# the heap size.  Specified in M.  If not specified, a reasonable
# estimate will be calculated based on total memory available.
#
# export HADOOP_CHILD_MAP_CONTAINER_BUFFER=256
# export HADOOP_CHILD_REDUCE_CONTAINER_BUFFER=512

# Mapreduce Slowstart, indicating percent of maps that should complete
# before reducers begin.
#
# If not specified, defaults to 0.05
#
# export HADOOP_MAPREDUCE_SLOWSTART=0.05

# Container Memory
#
# Memory on compute nodes for containers.  Typically "nice-chunk" less
# than actual memory on machine, b/c machine needs memory for its own
# needs (kernel, daemons, etc.).  Specified in megs.
#
# If not specified, a reasonable estimate will be calculated based on
# total memory on the system.
#
# export YARN_RESOURCE_MEMORY=32768

# Compression
#
# Should compression of outputs and intermediate data be enabled.
# Specify yes or no.  Defaults to no.
#
# Effectively, is time spend compressing data going to save you time
# on I/O.  Sometimes yes, sometimes no.
#
# export HADOOP_COMPRESSION=yes

# IO Sort Factors + MB
#
# The number of streams of files to sort while reducing and the memory
# amount to use while sorting.  This is a quite advanced mechanism
# taking into account many factors.  If not specified, some reasonable
# number will be calculated.
#
# export HADOOP_IO_SORT_FACTOR=10
# export HADOOP_IO_SORT_MB=100

# Parallel Copies
#
# The default number of parallel transfers run by reduce during the
# copy(shuffle) phase.  If not specified, some reasonable number will
# be calculated.
# export HADOOP_PARALLEL_COPIES=10

############################################################################
# Hadoop Filesystem Mode Configurations
############################################################################

# Set how the filesystem should be setup
#
# "hdfs" - Normal straight up HDFS if you have local disk in your
#          cluster.  This option is primarily for benchmarking and
#          probably shouldn't be used in the general case.
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

# Path for HDFS when using local disk
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
# yes, Magpie will do a rm -rf on HADOOP_HDFS_PATH.  This may be
# convenient for cleaning up your job after it has run.  This is
# particularly useful for HDFS, b/c on your next job run, you may not
# be able to get the nodes you want on your next run, leading to
# problems.
#
# export HADOOP_HDFS_PATH_CLEAR="yes"

# Lustre path to do Hadoop HDFS out of
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
# This path is used for creating local per-node paths.
#
export HADOOP_RAWNETWORKFS_PATH="/lustre/${USER}/rawnetworkfs/"

# If you have a local SSD, performance may be better to store
# intermediate data on it rather than Lustre or some other networked
# filesystem.  If the below environment variable is specified, local
# intermediate data will be stored in the specified directory.
# Otherwise it will go to an appropriate directory in Lustre/networked
# FS.
#
# Be wary, local SSDs stores may have less space than HDDs or
# networked file systems.  It can be easy to run out of space.
#
# If you want to specify multiple paths (such as multiple drives),
# make them comma separated (e.g. /dir1,/dir2,/dir3).  The multiple
# paths will be used for local intermediate data.
#
# export HADOOP_LOCALSTORE="/ssd/${USER}/localstore/"

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

# HDFS Block Size
#
# Commonly 134217728, 268435456, 536870912 (i.e. 128m, 256m, 512m)
#
# If not specified, defaults to 134217728
#
# export HADOOP_HDFS_BLOCKSIZE=134217728

# HDFS Replication
#
# HDFS commonly uses 3.  When doing HDFS over Lustre/NetworkFS, higher
# replication can also help with resilience if nodes fail.  You may
# wish to set this to < 3 to save space.
#
# If not specified, defaults to 3
#
# export HADOOP_HDFS_REPLICATION=3

# RawNetworkFS Block Size
#
# Commonly 33554432, 67108864, 134217728 (i.e. 32m, 64m, 128m)
#
# If not specified, defaults to 33554432
#
# export HADOOP_RAWNETWORKFS_BLOCKSIZE=33554432


############################################################################
# Pig Configurations
############################################################################

# Should Pig be setup
#
# Specify yes or no.  Defaults to no.
# 
# Note that unlike Hadoop or Zookeeper, Pig does not need to be
# enabled/disabled to be run with Hadoop.  For example, no daemons are setup.  
#
# If PIG_SETUP is enabled, this will inform Magpie to setup a
# configuration files and environment variables that will hopefully
# make it easier to run Pig w/ Hadoop.  You could leave this disabled
# and setup/config Pig as you need.
#
export PIG_SETUP=yes

# Pig Version
#
export PIG_VERSION="0.15.0"

# Path to your Pig build/binaries
#
# This should be accessible on all nodes in your allocation. Typically
# this is in an NFS mount.
#
# Ensure the build matches the Hadoop version this will run against.
#
export PIG_HOME="${HOME}/pig-${PIG_VERSION}"

# Directory where Pig configuration templates are stored
#
# If not specified, assumed to be $MAGPIE_SCRIPTS_HOME/conf
#
# export PIG_CONF_FILES="${HOME}/myconf"

# Path to store data local to each cluster node, typically something
# in /tmp.  This will store local conf files and log files for your
# job.  If local scratch space is not available, consider using the
# MAGPIE_NO_LOCAL_DIR_DIR option.  See README for more details.
#
export PIG_LOCAL_DIR="/tmp/${USER}/pig"

# Set how Pig should run
#
# "testpig" - Run a quick sanity test to see that pig is setup
#             correctly.  Testpig will do a simple ls of the root
#             directory of whatever filesytem you setup (e.g. hdfs,
#             lustre, etc.).
#
# "script" - execute a pig script indicated by PIG_SCRIPT_PATH.
#
# "interactive" - manually interact to run pig scripts. In this mode
#                 you'll login to the cluster node that is your
#                 'master' node and run pig scripts directly
#                 (e.g. bin/pig ...).
#
export PIG_MODE="testpig"

# Specify script to execute for "script" mode in PIG_MODE.  This pig
# script will be fed into pig via "pig ${PIG_SCRIPT_OPTS} ${PIG_SCRIPT_PATH}"
#
# export PIG_SCRIPT_PATH="${HOME}/my-pig-script"

# Specify options to specify when calling pig.
#
# A particularly useful option is -l <logfile>, to indicate where you
# would like the pig log file to go.
#
# Another useful option is -F or -stop_on_failure
#
# export PIG_SCRIPT_OPTS="-l ${HOME}/mypig.log"

# Pig Classpath
#
# Set the classpath you desire for pig.  This is the CLASSPATH you
# likely want to set to add additional jars for your run.
#
# export PIG_CLASSPATH="${HOME}/myjarfiles.jar"

# Pig Opts
#
# Extra Java runtime options
#
# export PIG_OPTS="-Djava.io.tmpdir=${PIG_LOCAL_JOB_DIR}/tmp"

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
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-setup
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-pre-run
if [ $? -ne 0 ]
then
    exit 1
fi
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-run
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-cleanup
mpirun $MPIRUN_OPTIONS $MAGPIE_SCRIPTS_HOME/magpie-post-run
