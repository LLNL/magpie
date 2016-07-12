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
        numcompare=`expr ${basenodecount} + ${zookeepernodecount}`
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
        numcompare=`expr ${basenodecount} + ${zookeepernodecount}`
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

    numcompare=`grep 'Kafka Servers are up.' $file | tail -1 | awk -F "/" '{ print $1 }'`

    num=`grep -e "Stopping Kafka" $file | wc -l`
    if [ "${num}" != "${numcompare}" ]; then
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

files=`find . -maxdepth 1 -name "${outputprefix}*interactivemode*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Entering \(.*\) interactive mode" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi

        num=`grep -e "*** Warning - 1 minute left" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi

        num=`grep -e "End of 'interactive' mode" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*jobtimeout*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Killing script, did not exit within time limit" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*catchprojectdependency*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        # This is the more common catch
        num1=`grep -e "\(.*\) requires \(.*\) to be setup, set \(.*\) to yes" $file | wc -l`
        # Possible nothing has been enabled that can run, also likely catch
        num2=`grep -e "there is nothing to setup" $file | wc -l`
        # This error is specific to Spark and Hadoop accidentally not enabled
        num3=`grep -e "must be set if Hadoop is not setup" $file | wc -l`
        if [ "${num1}" == "0" ] && [ "${num2}" == "0" ] && [ "${num3}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=""
for str in nosetjava nosetversion nosethome nosetscript nocoresettings badcoresettings requirehdfs requireyarn
do
    filestmp=`find . -maxdepth 1 -name "${outputprefix}*${str}*"`
    if [ -n "${filestmp}" ]
    then
        files="${files}${files:+" "}${filestmp}"
    fi
done

if [ -n "${files}" ]
then
    for file in $files
    do
        num=`grep -e "must be set" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badsetjava*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "JAVA_HOME does not point to a directory" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badsethome*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "\(.*\)_HOME does not point to a directory" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badsetscript*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num1=`grep -e "\(.*\)_SCRIPT_PATH does not point to a regular file" $file | wc -l`
        num2=`grep -e "\(.*\)_SCRIPT_PATH=\"\(.*\)\" does not have execute permissions" $file | wc -l`
        if [ "${num1}" == "0" ] && [ "${num2}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badjobtime*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "timelimit must be atleast the sum of MAGPIE_STARTUP_TIME & MAGPIE_SHUTDOWN_TIME" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badstartuptime*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "MAGPIE_STARTUP_TIME must be >= 5 minutes if MAGPIE_PRE_JOB_RUN is set" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badshutdowntime*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "MAGPIE_SHUTDOWN_TIME must be >= 10 minutes if MAGPIE_POST_JOB_RUN is set" $file | wc -l`
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*badnodecount*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        if echo ${file} | grep -q "small"
        then
            num=`grep -e "No remaining nodes for \(.*\), increase node count or adjust node allocations" $file | wc -l`
        else
            num=`grep -e "No remaining slave nodes after Zookeeper allocation" $file | wc -l`
        fi
        if [ "${num}" == "0" ]
        then
            echo "Error in $file"
        fi

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-hadoopterasort*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "completed successfully" $file | wc -l`
        if echo ${file} | grep -q "run-clustersyntheticcontrol"
        then
            if [ "${num}" != "14" ]; then
                echo "Error in $file"
            fi
        else
            if [ "${num}" != "2" ]; then
                echo "Error in $file"
            fi
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-scriptteragen*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "completed successfully" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-scriptterasort*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "completed successfully" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-hadoopupgradehdfs*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Finalize upgrade successful" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*hdfs-older-version*expected-failure*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "HDFS version at mount" $file | grep -e "is older than" | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_no_hdfs_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*hdfs-newer-version*expected-failure*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "HDFS version at mount" $file | grep -e "is newer than" | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_no_hdfs_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*hdfs-fewer-nodes*expected-failure*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "HDFS was last built using a larger slave node count" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_no_hdfs_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*decommissionhdfsnodes*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Decommissioned ${basenodecount} nodes" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        # On some jobs, Yarn may run, others maybe not, only test HDFS shutdown proper
        test_hdfs_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-testpig*"`
if [ -n "${files}" ]
then
    for file in ${files}
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
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-pigscript*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
    # Below only works on 0.14.0 and up
    # num=`grep -e "Pig script completed" $file | wc -l`
        
        num=`grep -e "1,2,3" $file | wc -l`
        if [ "${num}" != "2" ]; then
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-clustersyntheticcontrol*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Dumping out clusters from clusters" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hadoop_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-hbaseperformanceeval*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Summary of timings" $file | wc -l`
        if [ "${num}" != "2" ]; then
            echo "Error in $file"
        fi
        
        test_hdfs_shutdown $file
        test_zookeeper_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-scripthbasewritedata*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Summary of timings" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hdfs_shutdown $file
        test_zookeeper_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-scripthbasereaddata*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Summary of timings" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_hdfs_shutdown $file
        test_zookeeper_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-phoenixperformanceeval*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Time" $file | grep "sec(s)" | wc -l`
        if [ "${num}" != "7" ]; then
            echo "Error in $file"
        fi
        
        test_hdfs_shutdown $file
        test_zookeeper_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-sparkpi*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "Pi is roughly" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
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

files=""
for str in run-sparkwordcount run-pythonsparkwordcount
do
    filestmp=`find . -maxdepth 1 -name "${outputprefix}*${str}*"`
    if [ -n "${filestmp}" ]
    then
        files="${files}${files:+" "}${filestmp}"
    fi
done

if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "davidson: 4" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
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

files=`find . -maxdepth 1 -name "${outputprefix}*run-kafkaperformance*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "50000000 records sent" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
        fi
        
        test_kafka_shutdown $file

        test_output_finalize $file
    done
fi

files=`find . -maxdepth 1 -name "${outputprefix}*run-stormwordcount*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "WordCount no longer active, appears to have been killed correctly" $file | wc -l`
        if [ "${num}" != "1" ]; then
            echo "Error in $file"
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

files=`find . -maxdepth 1 -name "${outputprefix}*run-zookeeperruok*"`
if [ -n "${files}" ]
then
    for file in ${files}
    do
        num=`grep -e "imok" $file | wc -l`
        if [ "${num}" != "${zookeepernodecount}" ]; then
            echo "Error in $file"
        fi
        
        test_zookeeper_shutdown $file

        test_output_finalize $file
    done
fi
