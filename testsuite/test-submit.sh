#!/bin/sh

# How to submit

# XXX - haven't handled lsf-mpirun or msub-torque-pdsh yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

# Tests to run

defaulttests=y
hadooptests=y
pigtests=y
hbasetests=y
sparktests=y
stormtests=y
zookeepertests=y

dependencytests=y

largeperformanceruntests=n

# Misc config

jobsubmissionfile=magpie-test.log

# Test Setup

if [ "${submissiontype}" == "sbatch-srun" ]
then
    jobsubmitcmd="sbatch"
    jobsubmitcmdoption="-k"
    jobsubmitdependency="--dependency=afterany:\${previousjobid}"
    jobidstripcmd="awk '""{print \$4}""'"
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    jobsubmitcmd="msub"
    jobsubmitcmdoption=""
    jobsubmitdependency="-l depend=\${previousjobid}"
    jobidstripcmd="xargs"
fi

if [ -f "${jobsubmissionfile}" ]
then
    rm -f ${jobsubmissionfile}
fi
touch ${jobsubmissionfile}

BasicJobSubmit () {
    local jobsubmissionscript=$1

    if [ -f "${jobsubmissionscript}" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmissionscript}`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	jobid=`eval ${jobidstripfullcommand}`
	
	echo "File ${jobsubmissionscript} submitted with ID ${jobid}" >> ${jobsubmissionfile}
	
	previousjobid=${jobid}
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
    fi
}

DependentJobSubmit () {
    local jobsubmissionscript=$1

    if [ -f "${jobsubmissionscript}" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} ${jobsubmissionscript}`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	jobid=`eval ${jobidstripfullcommand}`
	
	echo "File ${jobsubmissionscript} submitted with ID ${jobid}, dependent on previous job ${previousjobid}" >> ${jobsubmissionfile}
    
	previousjobid=${jobid}
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
    fi
}

# Default Tests

if [ "${defaulttests}" == "y" ]
then
    BasicJobSubmit magpie.${submissiontype}-hadoop
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs
    BasicJobSubmit magpie.${submissiontype}-spark
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs
    BasicJobSubmit magpie.${submissiontype}-storm
    BasicJobSubmit magpie.${submissiontype}-zookeeper

    # Default No Local Dir Tests

    BasicJobSubmit magpie.${submissiontype}-hadoop-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-no-local-dir

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.4.0
        # achu : library incompatability between hadoop 2.4.0 & pig 0.14.0, pig script will commonly fail with
        # ERROR 1066: Unable to open iterator for alias data
        # org.apache.pig.impl.logicalLayer.FrontendException: ERROR 1066: Unable to open iterator for alias data
	# DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.4.0-pig-0.14.0
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.6.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.6.0-pig-0.14.0
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.7.1
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.7.1-pig-0.15.0
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-spark-1.5.1-bin-hadoop2.6
    fi
fi

# Hadoop Tests

if [ "${hadooptests}" == "y" ]
then
    for hadoopversion in 2.7.1
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-multiple-paths

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-multiple-paths-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-multiple-paths-no-local-dir

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    for hadoopversion in 2.6.0
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-multiple-paths
	
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-multiple-paths-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-multiple-paths-no-local-dir

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    for hadoopversion in 2.4.0
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-local-multiple-paths
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-local-multiple-paths

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-upgradehdfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-hdfs-older-version
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-upgradehdfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-more-nodes
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-fewer-nodes
	
	BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-more-nodes
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-fewer-nodes

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-more-nodes
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-fewer-nodes

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4A
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4A-hdfs-newer-version

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4B
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4B-hdfs-newer-version

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5A
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfs-newer-version

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5B
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5B-hdfs-newer-version
    fi
fi
    
# Pig Tests

if [ "${pigtests}" == "y" ]
then
    for pigversion in 0.15.0
    do
	for hadoopversion in 2.7.1
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script-no-local-dir
	done
    done
    
    for pigversion in 0.14.0
    do
	for hadoopversion in 2.6.0
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script-no-local-dir
	done
    done
    
    for pigversion in 0.12.0 0.14.0
    do
	for hadoopversion in 2.4.0 2.6.0
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}

	    # achu : library incompatability between hadoop 2.4.0 & pig 0.14.0, pig script will commonly fail with
	    # ERROR 1066: Unable to open iterator for alias data
	    # org.apache.pig.impl.logicalLayer.FrontendException: ERROR 1066: Unable to open iterator for alias data
	    if [ "${pigversion}" == "0.14.0" ] && [ "${hadoopversion}" == "2.4.0" ]
	    then
		continue
	    fi
	    
	    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0
	
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0
	
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0
    fi
fi

# Hbase Tests

if [ "${hbasetests}" == "y" ]
then
    for hbaseversion in 0.99.2 1.1.1 1.1.2 
    do
	for hadoopversion in 2.7.1 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local
		
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    done
	done
    done

    for hbaseversion in 0.98.9-hadoop2
    do
	for hadoopversion in 2.6.0 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs-no-local-dir
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    done
	done
    done

    for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
    do
	for hadoopversion in 2.4.0 2.6.0 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-networkfs-zookeeper-shared
		BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local
	    done
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6
    fi
fi

# Spark Tests

if [ "${sparktests}" == "y" ]
then

    for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
    do
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-no-local-dir
    done

    # only b/c this is Spark only w/o Hadoop 2.4
    for sparkversion in 1.3.0-bin-hadoop2.4 
    do
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
    do
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}
    done

    for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
    do
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
    do
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0
    done

    for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
    do
	BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
	BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4
    do
	BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
    done

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

  	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6

  	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.5.0-bin-hadoop2.6
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.5.0-bin-hadoop2.6
    fi
fi

# Storm Tests

if [ "${stormtests}" == "y" ]
then

    for stormversion in 0.9.5
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	    
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	done
    done

    for stormversion in 0.9.4
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	done
    done

    for stormversion in 0.9.3 0.9.4
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6

	BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6
	DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6
    fi
fi

# Zookeeper Tests

if [ "${zookeepertests}" == "y" ]
then
    for zookeeperversion in 3.4.5 3.4.6
    do
	BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}
	BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local
    done

    if [ "${dependencytests}" == "y" ]
    then
	echo "No Zookeeper Dependency Tests"
    fi
fi

