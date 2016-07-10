#!/bin/bash

source test-config.sh

verboseoutput=n

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
	-v|--verbose)
	    verboseoutput=y
	    ;;
	*)
            echo "Usage: test-validate [-v]"
	    exit 1
	    ;;
    esac
    shift
done

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
	numcompare=`expr ${basenodecount} \* 2`
    else
	numcompare=${basenodecount}
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
	numcompare=`expr ${basenodecount} \* 2`
    else
	numcompare=${basenodecount}
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
    local file=$1

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
    if echo ${file} | grep -q "more-nodes"
    then
	numcompare=`expr ${basenodecount} \* 2`
    else
	numcompare=${basenodecount}
    fi
    if [ "${num}" != "$numcompare" ]; then
	echo "Spark worker shutdown error in $file"
    fi
}

test_kafka_shutdown () {
    local file=$1

    numcompare=$(grep 'Kafka Servers are up.' $file | tail -1 | awk -F "/" '{ print $1 }')

    num=`grep -e "Stopping Kafka" $file | wc -l`
    if [ "${num}" != ${numcompare} ]; then
	echo "Kafka worker server shutdown error in $file" ${num}
    fi
}

test_zookeeper_shutdown () {
    local file=$1
    
    num=`grep -e "Stopping zookeeper ... STOPPED" $file | wc -l`
    if [ "${num}" != "${zookeepernodecount}" ]; then
        echo "Zookeeper shutdown error in $file"
    fi
}

test_output_finalize () {
    local file=$1

    num=`grep -e "Magpie Internal" $file | wc -l`
    if [ "${num}" != "0" ]; then
        echo "Internal Magpie error detected in $file"
    fi

    if [ "${verboseoutput}" == "y" ]
    then
	echo "File ${file} run through validation"
    fi
}

if ls ${outputprefix}*interactivemode* >& /dev/null
then
    for file in `ls ${outputprefix}*interactivemode*`
    do
	num=`grep -e "Entering \(.*\) interactive mode" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi

	num=`grep -e "*** Warning - 1 minute left" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi

	num=`grep -e "End of 'interactive' mode" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*jobtimeout* >& /dev/null
then
    for file in `ls ${outputprefix}*jobtimeout*`
    do
	num=`grep -e "Killing script, did not exit within time limit" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*catchprojectdependency* >& /dev/null
then
    for file in `ls ${outputprefix}*catchprojectdependency*`
    do
	# This is the more common catch
	num1=`grep -e "\(.*\) requires \(.*\) to be setup, set \(.*\) to yes" $file | wc -l`
	# Possible nothing has been enabled that can run, also likely catch
 	num2=`grep -e "there is nothing to setup" $file | wc -l`
	# This error is specific to Spark and Hadoop accidentally not enabled
	num3=`grep -e "must be set if Hadoop is not setup" $file | wc -l`
	if [ "${num1}" == "0" ] && [ "${num2}" == "0" ] && [ "${num3}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*nosetjava* >& /dev/null
then
    for file in `ls ${outputprefix}*nosetjava*`
    do
	num=`grep -e "JAVA_HOME must be set" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*badsetjava* >& /dev/null
then
    for file in `ls ${outputprefix}*badsetjava*`
    do
	num=`grep -e "JAVA_HOME does not point to a directory" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*nosetversion* >& /dev/null
then
    for file in `ls ${outputprefix}*nosetversion*`
    do
	num=`grep -e "\(.*\)_VERSION must be set" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*nosethome* >& /dev/null
then
    for file in `ls ${outputprefix}*nosethome*`
    do
	num=`grep -e "\(.*\)_HOME must be set" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*badsethome* >& /dev/null
then
    for file in `ls ${outputprefix}*badsethome*`
    do
	num=`grep -e "\(.*\)_HOME does not point to a directory" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*nosetscript* >& /dev/null
then
    for file in `ls ${outputprefix}*nosetscript*`
    do
	num=`grep -e "\(.*\)_SCRIPT_PATH must be set" $file | wc -l`
	if [ "${num}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*badsetscript* >& /dev/null
then
    for file in `ls ${outputprefix}*badsetscript*`
    do
	num1=`grep -e "\(.*\)_SCRIPT_PATH does not point to a regular file" $file | wc -l`
	num2=`grep -e "\(.*\)_SCRIPT_PATH=\"\(.*\)\" does not have execute permissions" $file | wc -l`
	if [ "${num1}" == "0" ] && [ "${num2}" == "0" ]
	then
	    echo "Job error in $file"
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*run-hadoopterasort* >& /dev/null
then
    for file in `ls ${outputprefix}*run-hadoopterasort*`
    do
	num=`grep -e "completed successfully" $file | wc -l`
	if echo ${file} | grep -q "run-clustersyntheticcontrol"
	then
	    if [ "${num}" != "14" ]; then
		echo "Job error in $file"
	    fi
	else
	    if [ "${num}" != "2" ]; then
		echo "Job error in $file"
	    fi
	fi
	
	test_hadoop_shutdown $file

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*decommissionhdfsnodes* >& /dev/null
then
    for file in `ls ${outputprefix}*decommissionhdfsnodes*`
    do
	num=`grep -e "Decommissioned ${basenodecount} nodes" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	# On some jobs, Yarn may run, others maybe not, only test HDFS shutdown proper
	test_hdfs_shutdown $file

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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

	test_output_finalize $file
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
	
	if echo ${file} | grep -q "usingyarn"
	then
	    test_yarn_shutdown $file
	else
	    test_spark_shutdown $file
	fi

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*run-sparkwordcount* >& /dev/null ||
    ls ${outputprefix}*run-pythonsparkwordcount* >& /dev/null
then
    if ls ${outputprefix}*run-sparkwordcount* >& /dev/null; then
	files1=`ls ${outputprefix}*run-sparkwordcount*`
    fi
    if ls ${outputprefix}*run-pythonsparkwordcount* >& /dev/null; then
	files2=`ls ${outputprefix}*run-pythonsparkwordcount*`
    fi
    for file in $files1 $files2
    do
	num=`grep -e "davidson: 4" $file | wc -l`
	if [ "${num}" != "1" ]; then
	    echo "Job error in $file"
	fi
	
	if echo ${file} | grep -q "usingyarn"
	then
	    test_yarn_shutdown $file
	else
	    test_spark_shutdown $file
	fi

	if ! echo ${file} | grep -q "rawnetworkfs"
	then
	    test_hdfs_shutdown $file
	fi

	test_output_finalize $file
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

	test_output_finalize $file
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
	    numcompare=`expr ${basenodecount} + ${zookeepernodecount}`
	else
	    numcompare=${basenodecount}
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

	test_output_finalize $file
    done
fi

if ls ${outputprefix}*run-zookeeperruok* >& /dev/null
then
    for file in `ls ${outputprefix}*run-zookeeperruok*`
    do
	num=`grep -e "imok" $file | wc -l`
	if [ "${num}" != "${zookeepernodecount}" ]; then
	    echo "Job error in $file"
	fi
	
	test_zookeeper_shutdown $file

	test_output_finalize $file
    done
fi
