#!/bin/sh

# Default Tests

sbatch -k ./magpie.sbatch-srun-hadoop
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs
sbatch -k ./magpie.sbatch-srun-spark
sbatch -k ./magpie.sbatch-srun-spark-with-hdfs
sbatch -k ./magpie.sbatch-srun-storm
sbatch -k ./magpie.sbatch-srun-zookeeper

# Hadoop Tests

sbatch -k ./magpie.sbatch-srun-hadoop-hdfs
sbatch -k ./magpie.sbatch-srun-hadoop-hdfs-multiple-paths
sbatch -k ./magpie.sbatch-srun-hadoop-hdfsovernetworkfs
sbatch -k ./magpie.sbatch-srun-hadoop-localstore
sbatch -k ./magpie.sbatch-srun-hadoop-localstore-multiple-paths
sbatch -k ./magpie.sbatch-srun-hadoop-largeperformancerun

# Pig Tests

sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-script

# Hbase Tests

sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-random-thread
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-zookeeper-local
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local

# Spark Tests

sbatch -k ./magpie.sbatch-srun-spark-with-rawnetworkfs

# Storm Tests

sbatch -k ./magpie.sbatch-srun-storm-zookeeper-local
sbatch -k ./magpie.sbatch-srun-storm-zookeeper-shared
sbatch -k ./magpie.sbatch-srun-storm-zookeeper-shared-local

# Zookeeper Tests

sbatch -k ./magpie.sbatch-srun-zookeeper-local

# Older Version Tests

sbatch -k ./magpie.sbatch-srun-hadoop-2-4-0
sbatch -k ./magpie.sbatch-srun-hadoop-2-6-0
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-0-12-0-hadoop-2-6-0
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-0-14-0-hadoop-2-6-0
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6
sbatch -k ./magpie.sbatch-srun-spark-0-9-1
sbatch -k ./magpie.sbatch-srun-spark-1-2-0
sbatch -k ./magpie.sbatch-srun-spark-1-3-0
sbatch -k ./magpie.sbatch-srun-spark-with-hdfs-0-9-1-hadoop-2-4-0
sbatch -k ./magpie.sbatch-srun-spark-with-hdfs-1-2-0-hadoop-2-4-0
sbatch -k ./magpie.sbatch-srun-spark-with-hdfs-1-3-0-hadoop-2-4-0
sbatch -k ./magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-6
sbatch -k ./magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6
sbatch -k ./magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-5
sbatch -k ./magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-5
sbatch -k ./magpie.sbatch-srun-zookeeper-3-4-5

# No Local Dir Tests

sbatch -k ./magpie.sbatch-srun-hadoop-no-local-dir
sbatch -k ./magpie.sbatch-srun-hadoop-and-pig-no-local-dir
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-no-local-dir
sbatch -k ./magpie.sbatch-srun-spark-no-local-dir
sbatch -k ./magpie.sbatch-srun-spark-with-hdfs-no-local-dir
sbatch -k ./magpie.sbatch-srun-storm-no-local-dir
sbatch -k ./magpie.sbatch-srun-zookeeper-no-local-dir

sbatch -k ./magpie.sbatch-srun-hadoop-2-6-0-no-local-dir
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir
sbatch -k ./magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6-no-local-dir
sbatch -k ./magpie.sbatch-srun-spark-1-3-0-no-local-dir
sbatch -k ./magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6-no-local-dir

# Dependency Tests

prev=`sbatch -k magpie.sbatch-srun-hadoop-dependency1 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-dependency1 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-and-pig-dependency2 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-and-pig-dependency2 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hbase-with-hdfs-dependency3 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hbase-with-hdfs-dependency3 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-spark-with-hdfs-dependency4 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-spark-with-hdfs-dependency4 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-storm-dependency5 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-storm-dependency5 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-and-pig-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hbase-with-hdfs-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-spark-with-hdfs-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-and-pig-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hbase-with-hdfs-dependency6 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-spark-with-hdfs-dependency6 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-2-4-0-dependency7 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-6-0-dependency7-hdfs-older-version | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-6-0-dependency7 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-7-1-dependency7-hdfs-older-version | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-7-1-dependency7-upgradehdfs | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-7-1-dependency7 | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-dependency8 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-dependency8-hdfs-more-nodes | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-dependency8-hdfs-fewer-nodes | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-2-7-1-dependency9 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-6-0-dependency9-hdfs-newer-version | awk '{print $4}'`

prev=`sbatch -k magpie.sbatch-srun-hadoop-2-6-0-dependency10 | awk '{print $4}'`
prev=`sbatch -k --dependency=afterany:${prev} magpie.sbatch-srun-hadoop-2-4-0-dependency10-hdfs-newer-version | awk '{print $4}'`

