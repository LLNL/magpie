#!/bin/sh

# Default Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop .
cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig .
cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs .
cp ../script-sbatch-srun/magpie.sbatch-srun-spark .
cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs .
cp ../script-sbatch-srun/magpie.sbatch-srun-storm .
cp ../script-sbatch-srun/magpie.sbatch-srun-storm ./magpie.sbatch-srun-zookeeper

sed -i -e 's/export MAGPIE_JOB_TYPE="storm"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.sbatch-srun-zookeeper
sed -i -e 's/export ZOOKEEPER_MODE="launch"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.sbatch-srun-zookeeper

# Hadoop Tests
cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-hdfs

sed -i -e 's/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.sbatch-srun-hadoop-hdfs
sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.sbatch-srun-hadoop-hdfs

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-hdfs-multiple-paths

sed -i -e 's/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.sbatch-srun-hadoop-hdfs-multiple-paths
sed -i -e 's/export HADOOP_HDFS_PATH="\/ssd\/tmp1\/\${USER}\/"/export HADOOP_HDFS_PATH="\/ssd\/tmp1\/\${USER}\/a,\/ssd\/tmp1\/\${USER}\/b,\/ssd\/tmp1\/\${USER}\/c"/' magpie.sbatch-srun-hadoop-hdfs-multiple-paths
sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.sbatch-srun-hadoop-hdfs-multiple-paths

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-hdfsovernetworkfs

sed -i -e 's/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.sbatch-srun-hadoop-hdfsovernetworkfs

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-localstore

sed -i -e 's/# export HADOOP_LOCALSTORE="\/ssd\/tmp1\/\${USER}\/localstore\/"/export HADOOP_LOCALSTORE="\/ssd\/tmp1\/\${USER}\/localstore\/"/' magpie.sbatch-srun-hadoop-localstore

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-localstore-multiple-paths

sed -i -e 's/# export HADOOP_LOCALSTORE="\/ssd\/tmp1\/\${USER}\/localstore\/"/export HADOOP_LOCALSTORE="\/ssd\/tmp1\/\${USER}\/localstore\/a,\/ssd\/tmp1\/\${USER}\/localstore\/b,\/ssd\/tmp1\/\${USER}\/localstore\/c"/' magpie.sbatch-srun-hadoop-localstore-multiple-paths

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-largeperformancerun

sed -i -e 's/# export HADOOP_TERASORT_SIZE=50000000/export HADOOP_TERASORT_SIZE=10000000000/' magpie.sbatch-srun-hadoop-largeperformancerun

# Note, b/c of MAPREDUCE-5528, not testing rawnetworkfs w/ terasort

# Pig Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig ./magpie.sbatch-srun-hadoop-and-pig-script

sed -i -e 's/export MAGPIE_JOB_TYPE="pig"/export MAGPIE_JOB_TYPE="script"/' ./magpie.sbatch-srun-hadoop-and-pig-script
sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="\${HOME}\/hadoop\/magpie\/submission-scripts\/tests\/mytestpig.sh"/' ./magpie.sbatch-srun-hadoop-and-pig-script

# Hbase Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs ./magpie.sbatch-srun-hbase-with-hdfs-random-thread

sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' ./magpie.sbatch-srun-hbase-with-hdfs-random-thread

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-zookeeper-local

sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/\${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/ssd\/tmp1\/\${USER}\/zookeeper\/"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-local

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared

sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local

sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/\${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/ssd\/tmp1\/\${USER}\/zookeeper\/"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local
sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.sbatch-srun-hbase-with-hdfs-zookeeper-shared-local

# Spark Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-spark ./magpie.sbatch-srun-spark-with-rawnetworkfs

sed -i -e 's/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' ./magpie.sbatch-srun-spark-with-rawnetworkfs

# Storm Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-zookeeper-local

sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.sbatch-srun-storm-zookeeper-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/\${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/ssd\/tmp1\/\${USER}\/zookeeper\/"/' magpie.sbatch-srun-storm-zookeeper-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.sbatch-srun-storm-zookeeper-local

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-zookeeper-shared

sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.sbatch-srun-storm-zookeeper-shared

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-zookeeper-shared-local

sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.sbatch-srun-storm-zookeeper-shared-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/\${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/ssd\/tmp1\/\${USER}\/zookeeper\/"/' magpie.sbatch-srun-storm-zookeeper-shared-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.sbatch-srun-storm-zookeeper-shared-local
sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.sbatch-srun-storm-zookeeper-shared-local

# Zookeeper Tests
 
cp ../script-sbatch-srun/magpie.sbatch-srun-storm ./magpie.sbatch-srun-zookeeper-local

sed -i -e 's/export MAGPIE_JOB_TYPE="storm"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.sbatch-srun-zookeeper-local
sed -i -e 's/export ZOOKEEPER_MODE="launch"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.sbatch-srun-zookeeper-local
sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.sbatch-srun-zookeeper-local 
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/\${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/ssd\/tmp1\/\${USER}\/zookeeper\/"/' magpie.sbatch-srun-zookeeper-local
sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.sbatch-srun-zookeeper-local

# Older Version Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-4-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-hadoop-2-4-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-4-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig magpie.sbatch-srun-hadoop-and-pig-0-12-0-hadoop-2-6-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-and-pig-0-12-0-hadoop-2-6-0
sed -i -e 's/export PIG_VERSION="0.15.0"/export PIG_VERSION="0.12.0"/' magpie.sbatch-srun-hadoop-and-pig-0-12-0-hadoop-2-6-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-and-pig-0-12-0-hadoop-2-6-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig magpie.sbatch-srun-hadoop-and-pig-0-14-0-hadoop-2-6-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-and-pig-0-14-0-hadoop-2-6-0
sed -i -e 's/export PIG_VERSION="0.15.0"/export PIG_VERSION="0.14.0"/' magpie.sbatch-srun-hadoop-and-pig-0-14-0-hadoop-2-6-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-and-pig-0-14-0-hadoop-2-6-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0
sed -i -e 's/export PIG_VERSION="0.15.0"/export PIG_VERSION="0.12.0"/' magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0
sed -i -e 's/export MAGPIE_JOB_TYPE="pig"/export MAGPIE_JOB_TYPE="script"/' ./magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0
sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="\${HOME}\/hadoop\/magpie\/submission-scripts\/tests\/mytestpig.sh"/' ./magpie.sbatch-srun-hadoop-and-pig-script-0-12-0-hadoop-2-6-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0
sed -i -e 's/export PIG_VERSION="0.15.0"/export PIG_VERSION="0.14.0"/' magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0
sed -i -e 's/export MAGPIE_JOB_TYPE="pig"/export MAGPIE_JOB_TYPE="script"/' ./magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0
sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="\${HOME}\/hadoop\/magpie\/submission-scripts\/tests\/mytestpig.sh"/' ./magpie.sbatch-srun-hadoop-and-pig-script-0-14-0-hadoop-2-6-0

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.98.3-hadoop2"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-6

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.98.9-hadoop2"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.98.3-hadoop2"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.5"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-3-hadoop-2-6-0-zookeeper-3-4-5

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.98.9-hadoop2"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.5"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-5

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.99.2"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6

cp ../script-sbatch-srun/magpie.sbatch-srun-spark magpie.sbatch-srun-spark-1-3-0

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' magpie.sbatch-srun-spark-1-3-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-1-3-0

cp ../script-sbatch-srun/magpie.sbatch-srun-spark magpie.sbatch-srun-spark-1-2-0

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="1.2.0-bin-hadoop2.4"/' magpie.sbatch-srun-spark-1-2-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-1-2-0

cp ../script-sbatch-srun/magpie.sbatch-srun-spark magpie.sbatch-srun-spark-0-9-1

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="0.9.1-bin-hadoop2"/' magpie.sbatch-srun-spark-0-9-1
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-0-9-1

cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs magpie.sbatch-srun-spark-with-hdfs-1-3-0-hadoop-2-4-0

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' magpie.sbatch-srun-spark-with-hdfs-1-3-0-hadoop-2-4-0
sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-spark-with-hdfs-1-3-0-hadoop-2-4-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-with-hdfs-1-3-0-hadoop-2-4-0

cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs magpie.sbatch-srun-spark-with-hdfs-1-2-0-hadoop-2-4-0

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="1.2.0-bin-hadoop2.4"/' magpie.sbatch-srun-spark-with-hdfs-1-2-0-hadoop-2-4-0
sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-spark-with-hdfs-1-2-0-hadoop-2-4-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-with-hdfs-1-2-0-hadoop-2-4-0

cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs magpie.sbatch-srun-spark-with-hdfs-0-9-1-hadoop-2-4-0

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="0.9.1-bin-hadoop2"/' magpie.sbatch-srun-spark-with-hdfs-0-9-1-hadoop-2-4-0
sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-spark-with-hdfs-0-9-1-hadoop-2-4-0
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-with-hdfs-0-9-1-hadoop-2-4-0

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-6

sed -i -e 's/export STORM_VERSION="0.9.5"/export STORM_VERSION="0.9.3"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-6
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-6
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-6

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6

sed -i -e 's/export STORM_VERSION="0.9.5"/export STORM_VERSION="0.9.4"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-5

sed -i -e 's/export STORM_VERSION="0.9.5"/export STORM_VERSION="0.9.3"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.5"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-5
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-storm-0-9-3-zookeeper-3-4-5

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-5

sed -i -e 's/export STORM_VERSION="0.9.5"/export STORM_VERSION="0.9.4"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.5"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-5
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-5

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-zookeeper-3-4-5

sed -i -e 's/export MAGPIE_JOB_TYPE="storm"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.sbatch-srun-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_MODE="launch"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.sbatch-srun-zookeeper-3-4-5
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.5"/' magpie.sbatch-srun-zookeeper-3-4-5

# No Local Dir Tests

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig magpie.sbatch-srun-hadoop-and-pig-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-spark magpie.sbatch-srun-spark-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs magpie.sbatch-srun-spark-with-hdfs-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-no-local-dir
cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-zookeeper-no-local-dir

sed -i -e 's/export MAGPIE_JOB_TYPE="storm"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.sbatch-srun-zookeeper-no-local-dir
sed -i -e 's/export ZOOKEEPER_MODE="launch"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.sbatch-srun-zookeeper-no-local-dir

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-no-local-dir

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-no-local-dir
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-no-local-dir

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.98.9-hadoop2"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hbase-with-hdfs-0-98-9-hadoop-2-6-0-zookeeper-3-4-6-no-local-dir

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6-no-local-dir

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export HBASE_VERSION="1.1.1"/export HBASE_VERSION="0.99.2"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-hbase-with-hdfs-0-99-2-hadoop-2-7-1-zookeeper-3-4-6-no-local-dir

cp ../script-sbatch-srun/magpie.sbatch-srun-spark magpie.sbatch-srun-spark-1-3-0-no-local-dir

sed -i -e 's/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' magpie.sbatch-srun-spark-1-3-0-no-local-dir
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-spark-1-3-0-no-local-dir

cp ../script-sbatch-srun/magpie.sbatch-srun-storm magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6-no-local-dir

sed -i -e 's/export STORM_VERSION="0.9.5"/export STORM_VERSION="0.9.4"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export ZOOKEEPER_VERSION="3.4.6"/export ZOOKEEPER_VERSION="3.4.6"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6-no-local-dir
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-storm-0-9-4-zookeeper-3-4-6-no-local-dir

sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' magpie*no-local-dir

# Dependency Tests
# Tests w/ dependencies, running one right after another (i.e. old hdfs/zookeeper dir works, etc.)

# First tests, run after each other

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop ./magpie.sbatch-srun-hadoop-dependency1
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/1\/"/' ./magpie.sbatch-srun-hadoop-dependency1

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig ./magpie.sbatch-srun-hadoop-and-pig-dependency2
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/2\/"/' ./magpie.sbatch-srun-hadoop-and-pig-dependency2

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs ./magpie.sbatch-srun-hbase-with-hdfs-dependency3
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/3\/"/' ./magpie.sbatch-srun-hbase-with-hdfs-dependency3
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper\/DEPENDENCYPREFIX\/3"/' ./magpie.sbatch-srun-hbase-with-hdfs-dependency3

cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs ./magpie.sbatch-srun-spark-with-hdfs-dependency4
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/4\/"/' ./magpie.sbatch-srun-spark-with-hdfs-dependency4

cp ../script-sbatch-srun/magpie.sbatch-srun-storm ./magpie.sbatch-srun-storm-dependency5
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/5\/"/' ./magpie.sbatch-srun-storm-dependency5
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper\/DEPENDENCYPREFIX\/5"/' ./magpie.sbatch-srun-storm-dependency5

# Second tests, run different things after one another

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop ./magpie.sbatch-srun-hadoop-dependency6
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/6\/"/' ./magpie.sbatch-srun-hadoop-dependency6

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop-and-pig ./magpie.sbatch-srun-hadoop-and-pig-dependency6
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/6\/"/' ./magpie.sbatch-srun-hadoop-and-pig-dependency6

cp ../script-sbatch-srun/magpie.sbatch-srun-hbase-with-hdfs ./magpie.sbatch-srun-hbase-with-hdfs-dependency6
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/6\/"/' ./magpie.sbatch-srun-hbase-with-hdfs-dependency6
sed -i -e 's/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper"/export ZOOKEEPER_DATA_DIR="\/p\/lscratchg\/${USER}\/testing\/zookeeper\/DEPENDENCYPREFIX\/6"/' ./magpie.sbatch-srun-hadoop-and-pig-dependency6

cp ../script-sbatch-srun/magpie.sbatch-srun-spark-with-hdfs ./magpie.sbatch-srun-spark-with-hdfs-dependency6
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/6\/"/' ./magpie.sbatch-srun-spark-with-hdfs-dependency6

# Third tests, upgrade hdfs, 2.4.0 -> 2.6.0 -> 2.7.1

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-4-0-dependency7

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-hadoop-2-4-0-dependency7
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-4-0-dependency7
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-4-0-dependency7

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-dependency7-hdfs-older-version

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-hdfs-older-version
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-hdfs-older-version
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-hdfs-older-version

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs
sed -i -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7-upgradehdfs

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-dependency7

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency7

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-7-1-dependency7-hdfs-older-version

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7-hdfs-older-version
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7-hdfs-older-version

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-7-1-dependency7-upgradehdfs

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7-upgradehdfs
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7-upgradehdfs
sed -i -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7-upgradehdfs

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-7-1-dependency7

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/7\/"/' magpie.sbatch-srun-hadoop-2-7-1-dependency7

# Fourth tests, increase size

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-dependency8

sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/8\/"/' magpie.sbatch-srun-hadoop-dependency8

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-dependency8-hdfs-more-nodes

sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/8\/"/' magpie.sbatch-srun-hadoop-dependency8-hdfs-more-nodes

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-dependency8-hdfs-fewer-nodes

sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/8\/"/' magpie.sbatch-srun-hadoop-dependency8-hdfs-fewer-nodes

# Fifth tests, detect newer hdfs version 2.7.1 from 2.6.0 

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-7-1-dependency9

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.7.1"/' magpie.sbatch-srun-hadoop-2-7-1-dependency9
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/9\/"/' magpie.sbatch-srun-hadoop-2-7-1-dependency9

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-dependency9-hdfs-newer-version

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-dependency9-hdfs-newer-version
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency9-hdfs-newer-version
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/9\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency9-hdfs-newer-version

# Sixth tests, detect newer hdfs version 2.6.0 from 2.4.0

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-6-0-dependency10

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.6.0"/' magpie.sbatch-srun-hadoop-2-6-0-dependency10
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency10
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/10\/"/' magpie.sbatch-srun-hadoop-2-6-0-dependency10

cp ../script-sbatch-srun/magpie.sbatch-srun-hadoop magpie.sbatch-srun-hadoop-2-4-0-dependency10-hdfs-newer-version

sed -i -e 's/export HADOOP_VERSION="2.7.1"/export HADOOP_VERSION="2.4.0"/' magpie.sbatch-srun-hadoop-2-4-0-dependency10-hdfs-newer-version
sed -i -e 's/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.sbatch-srun-hadoop-2-4-0-dependency10-hdfs-newer-version
sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/"/export HADOOP_HDFSOVERLUSTRE_PATH="\/p\/lscratchg\/\${USER}\/testing\/hdfsoverlustre\/DEPENDENCYPREFIX\/10\/"/' magpie.sbatch-srun-hadoop-2-4-0-dependency10-hdfs-newer-version

# Seds for all tests

# Names important, will be used in validation
sed -i -e "s/slurm-%j.out/slurm-hadoop-terasort-%j.out/" magpie.sbatch-srun-hadoop*
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-upgradehdfs-%j.out/" magpie.sbatch-srun-hadoop*upgradehdfs
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-and-pig-%j.out/" magpie.sbatch-srun-hadoop-and-pig*
sed -i -e "s/slurm-hadoop-and-pig-%j.out/slurm-hadoop-and-pig-script-%j.out/" magpie.sbatch-srun-hadoop-and-pig-script*
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-more-nodes-%j.out/" magpie.sbatch-srun-hadoop*hdfs-more-nodes
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-fewer-nodes-%j.out/" magpie.sbatch-srun-hadoop*hdfs-fewer-nodes
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-older-version-%j.out/" magpie.sbatch-srun-hadoop*hdfs-older-version
sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-newer-version-%j.out/" magpie.sbatch-srun-hadoop*hdfs-newer-version

sed -i -e "s/slurm-%j.out/slurm-hbase-%j.out/" magpie.sbatch-srun-hbase*
sed -i -e "s/slurm-hbase-%j.out/slurm-hbase-zookeeper-shared-%j.out/" magpie.sbatch-srun-hbase*zookeeper-shared

sed -i -e "s/slurm-%j.out/slurm-spark-pi-%j.out/" magpie.sbatch-srun-spark*
sed -i -e "s/slurm-spark-pi-%j.out/slurm-spark-wordcount-%j.out/" magpie.sbatch-srun-spark-with-hdfs*
sed -i -e "s/slurm-spark-pi-%j.out/slurm-spark-wordcount-rawnetworkfs-%j.out/" magpie.sbatch-srun-spark-with-rawnetworkfs*

sed -i -e "s/slurm-%j.out/slurm-storm-%j.out/" magpie.sbatch-srun-storm*
sed -i -e "s/slurm-storm-%j.out/slurm-storm-zookeeper-shared-%j.out/" magpie.sbatch-srun-storm*zookeeper-shared

sed -i -e "s/slurm-%j.out/slurm-zookeeper-%j.out/" magpie.sbatch-srun-zookeeper*

sed -i -e "s/-%j.out/-dependency-%j.out/" magpie.sbatch-srun*dependency*

# special node sizes first
sed -i -e "s/<my node count>/17/" magpie.sbatch-srun*more-nodes
sed -i -e "s/<my node count>/8/" magpie.sbatch-srun*hdfs-fewer-nodes
sed -i -e "s/<my node count>/9/" magpie.sbatch-srun-hadoop* magpie.sbatch-srun-spark* magpie.sbatch-srun-zookeeper*
sed -i -e "s/<my node count>/12/" magpie.sbatch-srun-hbase-with-hdfs* magpie.sbatch-srun-storm* 

sed -i -e "s/<my time in minutes>/300/" magpie.sbatch-srun-*largeperformancerun
sed -i -e "s/<my time in minutes>/90/" magpie.sbatch-srun-hadoop* magpie.sbatch-srun-spark* magpie.sbatch-srun-storm* magpie.sbatch-srun-zookeeper*
sed -i -e "s/<my time in minutes>/120/" magpie.sbatch-srun-hbase-with-hdfs*

sed -i -e "s/<my job name>/test/" magpie*

sed -i -e "s/<my partition>/pc6220/" magpie*

sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.sbatch-srun-spark-with-hdfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' magpie.sbatch-srun-spark-with-hdfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/\${HOME}\/hadoop\/magpie\/submission-scripts\/tests\/mywordcountfile\"/' magpie.sbatch-srun-spark-with-hdfs*

sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.sbatch-srun-spark-with-rawnetworkfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/\${HOME}\/hadoop\/magpie\/submission-scripts\/tests\/mywordcountfile\"/' magpie.sbatch-srun-spark-with-rawnetworkfs*

ls magpie* | grep -v dependency | xargs sed -i -e 's/# export HADOOP_PER_JOB_HDFS_PATH="yes"/export HADOOP_PER_JOB_HDFS_PATH="yes"/'
ls magpie* | grep -v dependency | xargs sed -i -e 's/# export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/'

sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\${HOME}\/magpie-my-post-job-script"/export MAGPIE_POST_JOB_RUN="\${MAGPIE_SCRIPTS_HOME}\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' magpie*

dependencyprefix=`date +"%Y%m%d%N"`

sed -i -e "s/DEPENDENCYPREFIX/${dependencyprefix}/" magpie*
