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

verboseoutput=n

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

test_kafka_shutdown () {
    local file=$1

    numcompare=$(grep 'Kafka Servers are up.' $file | awk -F "/" '{ print $1 }')

    num=`grep -e "Stopping Kafka" $file | wc -l`
    if [ "${num}" != ${numcompare} ]; then
	echo "Kafka worker server shutdown error in $file" ${num}
    fi
}

test_zookeeper_shutdown () {
    local file=$1
    
    num=`grep -e "Stopping zookeeper ... STOPPED" $file | wc -l`
    if [ "${num}" != "3" ]; then
        echo "Zookeeper shutdown error in $file"
    fi
}

if ls ${outputprefix}*run-hadoopterasort* >& /dev/null
then
    for file in `ls ${outputprefix}*run-hadoopterasort*`
    do
	num=`grep -e "completed successfully" $file | wc -l`
	if [ "${num}" != "2" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-scriptteragen* >& /dev/null
then
    for file in `ls ${outputprefix}*run-scriptteragen*`
    do
	num=`grep -e "completed successfully" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-scriptterasort* >& /dev/null
then
    for file in `ls ${outputprefix}*run-scriptterasort*`
    do
	num=`grep -e "completed successfully" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-hadoopupgradehdfs* >& /dev/null
then
    for file in `ls ${outputprefix}*run-hadoopupgradehdfs*`
    do
	num=`grep -e "Finalize upgrade successful" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*hdfs-older-version*expected-failure* >& /dev/null
then
    for file in `ls ${outputprefix}*hdfs-older-version*expected-failure*`
    do
	num=`grep -e "HDFS version at mount" $file | grep -e "is older than" | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_no_hdfs_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*hdfs-newer-version*expected-failure* >& /dev/null
then
    for file in `ls ${outputprefix}*hdfs-newer-version*expected-failure*`
    do
	num=`grep -e "HDFS version at mount" $file | grep -e "is newer than" | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_no_hdfs_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*hdfs-fewer-nodes*expected-failure* >& /dev/null
then
    for file in `ls ${outputprefix}*hdfs-fewer-nodes*expected-failure*`
    do
	num=`grep -e "HDFS was last built using a larger slave node count" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_no_hdfs_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*decommissionhdfsnodes* >& /dev/null
then
    for file in `ls ${outputprefix}*decommissionhdfsnodes*`
    do
	num=`grep -e "Decommissioned 8 nodes" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	# On some jobs, Yarn may run, others maybe not, only test HDFS shutdown proper
	test_hdfs_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-testpig* >& /dev/null
then
    for file in `ls ${outputprefix}*run-testpig*`
    do
    # Below only works on 0.14.0 and up
    # num=`grep -e "Pig script completed" $file | wc -l`
	
	if echo ${file} | grep -q "rawnetworkfs"
	then
	    num=`grep -e "file:\/" $file | grep "<dir>" | wc -l`
	else
	    num=`grep -e "hdfs:\/\/" $file | grep "<dir>" | wc -l`
	fi
	if [ ! "${num}" -gt "0" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-pigscript* >& /dev/null
then
    for file in `ls ${outputprefix}*run-pigscript*`
    do
    # Below only works on 0.14.0 and up
    # num=`grep -e "Pig script completed" $file | wc -l`
	
	num=`grep -e "1,2,3" $file | wc -l`
	if [ "${num}" != "2" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-clustersyntheticcontrol* >& /dev/null
then
    for file in `ls ${outputprefix}*run-clustersyntheticcontrol*`
    do
	num=`grep -e "Dumping out clusters from clusters" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hadoop_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-hbaseperformanceeval* >& /dev/null
then
    for file in `ls ${outputprefix}*run-hbaseperformanceeval*`
    do
	num=`grep -e "Summary of timings" $file | wc -l`
	if [ "${num}" != "2" ]; then
	    echo "Job error in $file"
	fi
	
	test_hdfs_shutdown $file
	test_zookeeper_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-scripthbasewritedata* >& /dev/null
then
    for file in `ls ${outputprefix}*run-scripthbasewritedata*`
    do
	num=`grep -e "Summary of timings" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hdfs_shutdown $file
	test_zookeeper_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-scripthbasereaddata* >& /dev/null
then
    for file in `ls ${outputprefix}*run-scripthbasereaddata*`
    do
	num=`grep -e "Summary of timings" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_hdfs_shutdown $file
	test_zookeeper_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-phoenixperformanceeval* >& /dev/null
then
    for file in `ls ${outputprefix}*run-phoenixperformanceeval*`
    do
	num=`grep -e "Time" $file | grep "sec(s)" | wc -l`
	if [ "${num}" != "7" ]; then
	    echo "Job error in $file"
	fi
	
	test_hdfs_shutdown $file
	test_zookeeper_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-sparkpi* >& /dev/null
then
    for file in `ls ${outputprefix}*run-sparkpi*`
    do
	num=`grep -e "Pi is roughly" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_spark_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-sparkwordcount* >& /dev/null
then
    for file in `ls ${outputprefix}*run-sparkwordcount*`
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

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-kafkaperformance* >& /dev/null
then
    for file in `ls ${outputprefix}*run-kafkaperformance*`
    do
	num=`grep -e "50000000 records sent" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	test_kafka_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-stormwordcount* >& /dev/null
then
    for file in `ls ${outputprefix}*run-stormwordcount*`
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

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi

if ls ${outputprefix}*run-zookeeperruok* >& /dev/null
then
    for file in `ls ${outputprefix}*run-zookeeperruok*`
    do
	num=`grep -e "imok" $file | wc -l`
	if [ "${num}" != "3" ]; then
	    echo "Job error in $file"
	fi
	
	test_zookeeper_shutdown $file

	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${file} run through validation"
	fi
    done
fi
