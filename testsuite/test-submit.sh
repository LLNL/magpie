#!/bin/sh

# How to submit

# XXX - haven't handled msub-torque-pdsh yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

# Tests to run

defaulttests=y
hadooptests=y
pigtests=y
mahouttests=y
hbasetests=y
phoenixtests=y
sparktests=y
stormtests=y
kafkatests=y
zookeepertests=y

# Toggle y/n for different test types
# standardtests: not using MAGPIE_NO_LOCAL_DIR
# nolocaldirtests: using MAGPIE_NO_LOCAL_DIR
# dependencytests: check dependencies
# largeperformanceruntests: run performance tests
standardtests=y
nolocaldirtests=y
dependencytests=y
largeperformanceruntests=n

verboseoutput=n

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
elif [ "${submissiontype}" == "lsf-mpirun" ]
then
    jobsubmitcmd="bsub"
    jobsubmitcmdoption="<"
    jobsubmitdependency="-w 'exit\(\${previousjobid}\)'"
    jobidstripcmd="sed -n -e 's/Job <\([0-9]*\)>.*/\1/p'"
fi

if [ -f "${jobsubmissionfile}" ]
then
    dateappend=`date +"%Y%m%d-%N"`
    mv ${jobsubmissionfile} ${jobsubmissionfile}.${dateappend}
fi
touch ${jobsubmissionfile}

BasicJobSubmit () {
    local jobsubmissionscript=$1

    if [ -f "${jobsubmissionscript}" ]
    then
	jobsubmitoutput=$(eval "${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmissionscript}")
	jobidstripfullcommand="echo '${jobsubmitoutput}' | ${jobidstripcmd}"
	jobid=$(eval ${jobidstripfullcommand})
	
	echo "File ${jobsubmissionscript} submitted with ID ${jobid}" >> ${jobsubmissionfile}
	
	previousjobid=${jobid}
	jobsubmitdependencyexpand=$(eval echo ${jobsubmitdependency})
	previousjobsubmitted=y
    else
	if [ "${verboseoutput}" = "y" ]
	then
	    echo "File ${jobsubmissionscript} not found" >> ${jobsubmissionfile}
	fi
	previousjobsubmitted=n
    fi
}

DependentJobSubmit () {
    local jobsubmissionscript=$1

    if [ "${previousjobsubmitted}" == "y" ]
    then
	if [ -f "${jobsubmissionscript}" ]
	then
	    jobsubmitoutput=$(eval "${jobsubmitcmd} ${jobsubmitdependencyexpand} ${jobsubmitcmdoption} ${jobsubmissionscript}")
	    jobidstripfullcommand="echo '${jobsubmitoutput}' | ${jobidstripcmd}"
	    jobid=$(eval ${jobidstripfullcommand})
	    
	    echo "File ${jobsubmissionscript} submitted with ID ${jobid}, dependent on previous job ${previousjobid}" >> ${jobsubmissionfile}
	    
	    previousjobid=${jobid}
	    jobsubmitdependencyexpand=$(eval echo ${jobsubmitdependency})
	    previousjobsubmitted=y
	else
	    if [ "${verboseoutput}" = "y" ]
	    then
		echo "File ${jobsubmissionscript} not found" >> ${jobsubmissionfile}
	    fi
	    previousjobsubmitted=n
	fi
    else
	if [ -f "${jobsubmissionscript}" ]
	then
	    if [ "${verboseoutput}" = "y" ]
	    then
		echo "File ${jobsubmissionscript} not submitted - prior job in dependency chain not submitted" >> ${jobsubmissionfile}
	    fi
	    previousjobsubmitted=n
	else
	    if [ "${verboseoutput}" = "y" ]
	    then
		echo "File ${jobsubmissionscript} not found" >> ${jobsubmissionfile}
	    fi
	    previousjobsubmitted=n
	fi
    fi
}

# Default Tests

if [ "${defaulttests}" == "y" ]
then
    if [ "${standardtests}" == "y" ]
    then
        BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort
        BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig
        BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol
        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval
        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval
        BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi
        BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount
        BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount
        BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok
    fi
    # Default No Local Dir Tests
    
    if [ "${nolocaldirtests}" == "y" ]
    then
        BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-no-local-dir
        BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
    fi

    if [ "${dependencytests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.2.0-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.2.0-pig-0.12.0-run-testpig
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-spark-0.9.1-bin-hadoop2-run-sparkwordcount

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.4.0-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.4.0-pig-0.12.0-run-testpig
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.6.0-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.6.0-pig-0.14.0-run-testpig
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1D-hadoop-2.7.0-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1D-hadoop-2.7.0-pig-0.15.0-run-testpig
	DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyGlobalOrder1D-hadoop-2.7.0-mahout-0.11.1-run-clustersyntheticcontrol
	DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-hbase-1.1.3-zookeeper-3.4.7-run-hbaseperformanceeval
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-spark-1.5.0-bin-hadoop2.6-run-sparkwordcount
    fi
fi

# Hadoop Tests

if [ "${hadooptests}" == "y" ]
then
    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort
        fi
        
        if [ "${nolocaldirtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir
        fi
    
        if [ "${largeperformanceruntests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort
        fi
    done
    
    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort
        fi
 
        if [ "${nolocaldirtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir
        fi
    
        if [ "${largeperformanceruntests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort
        fi
    done

    if [ "${dependencytests}" == "y" ]
    then
	for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	done

	for hadoopversion in 2.7.0 2.7.1 2.7.2
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	done

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfs-older-version-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopupgradehdfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopupgradehdfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfs-older-version-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopupgradehdfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopterasort

	for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort


	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	done

	for hadoopversion in 2.7.0 2.7.1 2.7.2
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort

	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
 	done

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure

	BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

	for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort

	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	done

	for hadoopversion in 2.7.0 2.7.1 2.7.2
	do
	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort

	    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	done

    fi
fi
    
# Pig Tests

if [ "${pigtests}" == "y" ]
then
    for pigversion in 0.12.0 0.12.1
    do
        for hadoopversion in 2.4.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
            fi
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
            fi
        done
    done
    
    for pigversion in 0.13.0 0.14.0
    do
        for hadoopversion in 2.6.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
            fi
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
            fi
        done
    done
    
    for pigversion in 0.15.0
    do
        for hadoopversion in 2.7.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
            fi
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
            fi
        done
    done


    if [ "${dependencytests}" == "y" ]
    then
	for pigversion in 0.12.0 0.12.1
	do
	    for hadoopversion in 2.4.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done

	for pigversion in 0.13.0 0.14.0
	do
	    for hadoopversion in 2.6.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done

	for pigversion in 0.15.0
	do
	    for hadoopversion in 2.7.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done

	for pigversion in 0.12.0 0.12.1
	do
	    for hadoopversion in 2.4.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done

	for pigversion in 0.13.0 0.14.0
	do
	    for hadoopversion in 2.6.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done

	for pigversion in 0.15.0
	do
	    for hadoopversion in 2.7.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-no-copy-run-pigscript
	    done
	done
    fi
fi

# Mahout Tests

if [ "${mahouttests}" == "y" ]
then
    for mahoutversion in 0.11.0 0.11.1
    do
        for hadoopversion in 2.7.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
            fi
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir
            fi
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for mahoutversion in 0.11.0 0.11.1
	do
	    for hadoopversion in 2.7.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	    done
	done

	for mahoutversion in 0.11.0 0.11.1
	do
	    for hadoopversion in 2.7.0
	    do
		BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
		DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	    done
	done
    fi
fi

# Hbase Tests

if [ "${hbasetests}" == "y" ]
then
    for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
    do
        for hadoopversion in 2.6.0
        do
            for zookeeperversion in 3.4.6
            do
                if [ "${standardtests}" == "y" ]
                then
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-networkfs-zookeeper-shared-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                    
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-networkfs-zookeeper-shared-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                fi
            
                if [ "${nolocaldirtests}" == "y" ]
                then
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                fi
            done
        done
    done
    
    for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2 1.1.3
    do
        for hadoopversion in 2.7.0
        do
            for zookeeperversion in 3.4.7
            do
                if [ "${standardtests}" == "y" ]
                then
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
            
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
                    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
                fi
                
                if [ "${nolocaldirtests}" == "y" ]
                then
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-localdir
            	    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-localdir
                fi
            done
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
	do
	    for hadoopversion in 2.6.0
	    do
		for zookeeperversion in 3.4.6
		do
		    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		done
	    done
	done

	for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2 1.1.3
	do
	    for hadoopversion in 2.7.0
	    do
		for zookeeperversion in 3.4.7
		do
		    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		done
	    done
	done

	for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
	do
	    for hadoopversion in 2.6.0
	    do
		for zookeeperversion in 3.4.6
		do
		    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		done
	    done
	done

	for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2 1.1.3
	do
	    for hadoopversion in 2.7.0
	    do
		for zookeeperversion in 3.4.7
		do
		    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		done
	    done
	done
    fi
fi

# Phoenix Tests

if [ "${phoenixtests}" == "y" ]
then
    for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
    do
        for hbaseversion in 1.1.3
        do
            for hadoopversion in 2.7.0
            do
                for zookeeperversion in 3.4.7
                do
                    if [ "${standardtests}" == "y" ]
                    then
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval
                        
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval
                    fi
                  
                    if [ "${nolocaldirtests}" == "y" ]
                    then
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
                        
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
                        BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
                    fi
                done
            done
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
	do
	    for hbaseversion in 1.1.3
	    do
		for hadoopversion in 2.7.0
		do
		    for zookeeperversion in 3.4.7
		    do
			BasicJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
		    done
		done
	    done
	done

	for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
	do
	    for hbaseversion in 1.1.3
	    do
		for hadoopversion in 2.7.0
		do
		    for zookeeperversion in 3.4.7
		    do
			BasicJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
		    done
		done
	    done
	done

	for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
	do
	    for hbaseversion in 1.1.3
	    do
		for hadoopversion in 2.7.0
		do
		    for zookeeperversion in 3.4.7
		    do
			BasicJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    done
		done
	    done
	done

	for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
	do
	    for hbaseversion in 1.1.3
	    do
		for hadoopversion in 2.7.0
		do
		    for zookeeperversion in 3.4.7
		    do
			BasicJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
			DependentJobSubmit ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
		    done
		done
	    done
	done
    fi
fi

# Spark Tests

if [ "${sparktests}" == "y" ]
then
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
        fi
    done
    
    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
        fi
        if [ "${nolocaldirtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
        fi
    done
    
    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
        fi
        if [ "${nolocaldirtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
        fi
    done
    
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
        for hadoopversion in 2.2.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount
            fi
        done
    done
    
    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
        for hadoopversion in 2.4.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount
            fi
    
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount-no-local-dir
            fi
        done
    done
    
    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6
    do
        for hadoopversion in 2.6.0
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount
                BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount
            fi
    
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount-no-local-dir
            fi
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
	do
	    for hadoopversion in 2.2.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
	    for hadoopversion in 2.4.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6
	do
	    for hadoopversion in 2.6.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
	do
	    for hadoopversion in 2.2.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
	    for hadoopversion in 2.4.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6
	do
	    for hadoopversion in 2.6.0
	    do
 		BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
		DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	    done
	done

	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
 	    BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount
	    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount
	done

	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6
	do
 	    BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount
	    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount
	done
    fi
fi

# Storm Tests

if [ "${stormtests}" == "y" ]
then
    for stormversion in 0.9.3 0.9.4
    do
        for zookeeperversion in 3.4.6
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount
            fi
    
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-run-stormwordcount-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-run-stormwordcount-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir
            fi
        done
    done
    
    for stormversion in 0.9.5
    do
        for zookeeperversion in 3.4.7
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount
            fi
    	
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir
            fi
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for stormversion in 0.9.3 0.9.4
	do
	    for zookeeperversion in 3.4.6
	    do
		BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
		DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
	    done
	done

	for stormversion in 0.9.5
	do
	    for zookeeperversion in 3.4.7
	    do
		BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
		DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
	    done
	done
    fi
fi

# Kafka Tests

if [ "${kafkatests}" == "y" ]
then
    for kafkaversion in 2.11-0.9.0.0
    do
        for zookeeperversion in 3.4.7
        do
            if [ "${standardtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance
            fi
    	
            if [ "${nolocaldirtests}" == "y" ]
            then
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance-no-local-dir
            fi
        done
    done

    if [ "${dependencytests}" == "y" ]
    then
	for kafkaversion in 2.11-0.9.0.0
	do
	    for zookeeperversion in 3.4.7
	    do
		BasicJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
		DependentJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
	    done
	done
    fi
fi

# Zookeeper Tests

if [ "${zookeepertests}" == "y" ]
then
    for zookeeperversion in 3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.4.5 3.4.6 3.4.7
    do
        if [ "${standardtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
            BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
        fi
        if [ "${nolocaldirtests}" == "y" ]
        then
            BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
            BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir
        fi
    done

    if [ "${dependencytests}" == "y" ]
    then
	echo "No Zookeeper Dependency Tests"
    fi
fi

