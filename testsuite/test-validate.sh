#!/bin/bash

# Which tests to generate

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

if [ "${submissiontype}" == "lsf-mpirun" ]
then
    outputprefix="lsf"
elif [ "${submissiontype}" == "msub-slurm-srun" ] || [ "${submissiontype}" == "msub-torque-pdsh" ]
then
    outputprefix="moab"
elif [ "${submissiontype}" == "sbatch-srun" ]
then
    outputprefix="slurm"
fi

test_yarn_shutdown () {
    local file=$1
    num=`grep -e "stopping yarn daemons" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Yarn shutdown error in $file"
    fi

    num=`grep -e "stopping resourcemanager" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Yarn shutdown error in $file"
    fi

    num=`grep -e "stopping nodemanager" $file | wc -l`
    if echo ${file} | grep -q "zookeeper-shared"
    then
	numcompare=11
    elif echo ${file} | grep -q "hdfs-more-nodes"
    then
	numcompare=16
    else
	numcompare=8
    fi
    if [ "${num}" != "$numcompare" ]; then
	echo "Yarn nodemanager shutdown error in $file"
    fi
}

test_hdfs_shutdown () {
    local file=$1
    num=`grep -e "stopping namenode" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Namenode shutdown error in $file"
    fi

    num=`grep -e "stopping datanode" $file | wc -l`
    if echo ${file} | grep -q "zookeeper-shared"
    then
	numcompare=11
    elif echo ${file} | grep -q "hdfs-more-nodes"
    then
	numcompare=16
    else
	numcompare=8
    fi
    if [ "${num}" != "$numcompare" ]; then
	echo "Datanode shutdown error in $file"
    fi

    num=`grep -e "stopping secondarynamenode" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "secondary namenode shutdown error in $file"
    fi
}

test_hadoop_shutdown () {

    test_yarn_shutdown $file

    test_hdfs_shutdown $file
}

test_no_hdfs_shutdown () {
    local file=$1
    num=`grep -e "stopping namenode" $file | wc -l`
    if [ "${num}" != "0" ]; then
	echo "Namenode shutdown error in $file"
    fi

    num=`grep -e "stopping datanode" $file | wc -l`
    if [ "${num}" != "0" ]; then
	echo "Datanode shutdown error in $file"
    fi

    num=`grep -e "stopping secondarynamenode" $file | wc -l`
    if [ "${num}" != "0" ]; then
	echo "secondary namenode shutdown error in $file"
    fi
}

test_spark_shutdown () {
    local file=$1

    num=`grep -e "stopping org.apache.spark.deploy.master.Master" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Spark master shutdown error in $file"
    fi

    num=`grep -e "stopping org.apache.spark.deploy.worker.Worker" $file | wc -l`
    if [ "${num}" != "8" ]; then
	echo "Spark worker shutdown error in $file"
    fi
}

test_zookeeper_shutdown () {
    local file=$1
    
    num=`grep -e "Stopping zookeeper ... STOPPED" $file | wc -l`
    if [ "${num}" != "3" ]; then
        echo "Zookeeper shutdown error in $file"
    fi
}

for file in `ls ${outputprefix}-hadoop-terasort*`
do
    num=`grep -e "completed successfully" $file | wc -l`
    if [ "${num}" != "2" ]; then
	echo "Job error in $file"
    fi

    test_hadoop_shutdown $file
done

for file in `ls ${outputprefix}-hadoop-upgradehdfs*`
do
    num=`grep -e "Finalize upgrade successful" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_hadoop_shutdown $file
done

for file in `ls ${outputprefix}-hadoop-hdfs-older-version*`
do
    num=`grep -e "HDFS version at mount" $file | grep -e "is older than" | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_no_hdfs_shutdown $file
done

for file in `ls ${outputprefix}-hadoop-hdfs-newer-version*`
do
    num=`grep -e "HDFS version at mount" $file | grep -e "is newer than" | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_no_hdfs_shutdown $file
done

for file in `ls ${outputprefix}-hadoop-hdfs-fewer-nodes*`
do
    num=`grep -e "HDFS was last built using a larger slave node count" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_no_hdfs_shutdown $file
done

for file in `ls ${outputprefix}-hadoop-and-pig*`
do
    # Below only works on 0.14.0 and up
    # num=`grep -e "Pig script completed" $file | wc -l`

    if echo ${file} | grep -q "pig-script"
    then
	num=`grep -e "1,2,3" $file | wc -l`
	if [ "${num}" != "2" ]; then
	    echo "Job error in $file"
	fi
    else
	
	if echo ${file} | grep -q "rawnetworkfs"
	then
	    num=`grep -e "file:\/" $file | grep "<dir>" | wc -l`
	else
	    num=`grep -e "hdfs:\/\/" $file | grep "<dir>" | wc -l`
	fi
	if [ ! "${num}" -gt "0" ]; then
	    echo "Job error in $file"
	fi
    fi

    if echo ${file} | grep -q "rawnetworkfs"
    then
	test_yarn_shutdown $file
    else
	test_hadoop_shutdown $file
    fi
done

for file in `ls ${outputprefix}-hbase*`
do
    num=`grep -e "Summary of timings" $file | wc -l`
    if [ "${num}" != "2" ]; then
	echo "Job error in $file"
    fi

    test_hdfs_shutdown $file
    test_zookeeper_shutdown $file
done

for file in `ls ${outputprefix}-spark-pi*`
do
    num=`grep -e "Pi is roughly" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_spark_shutdown $file
done

for file in `ls ${outputprefix}-spark-wordcount*`
do
    num=`grep -e "d: 4" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    test_spark_shutdown $file
    if ! echo ${file} | grep -q "rawnetworkfs"
    then
	test_hdfs_shutdown $file
    fi
done

for file in `ls ${outputprefix}-storm*`
do
    num=`grep -e "WordCount no longer active, appears to have been killed correctly" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Job error in $file"
    fi

    num=`grep -e "Killing Storm nimbus" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "nimbus shutdown error in $file"
    fi

    num=`grep -e "Killing Storm ui" $file | wc -l`
    if [ "${num}" != "1" ]; then
	echo "Storm ui shutdown error in $file"
    fi

    if echo ${file} | grep -q "zookeeper-shared"
    then
	numcompare=11
    else
	numcompare=8
    fi

    num=`grep -e "Killing Storm supervisor" $file | wc -l`
    if [ "${num}" != "$numcompare" ]; then
	echo "Storm supervisor shutdown error in $file"
    fi

    num=`grep -e "Killing Storm logviewer" $file | wc -l`
    if [ "${num}" != "$numcompare" ]; then
	echo "Storm logviewer shutdown error in $file"
    fi

    test_zookeeper_shutdown $file
done

for file in `ls ${outputprefix}-zookeeper*`
do
    num=`grep -e "imok" $file | wc -l`
    if [ "${num}" != "3" ]; then
	echo "Job error in $file"
    fi

    test_zookeeper_shutdown $file
done
