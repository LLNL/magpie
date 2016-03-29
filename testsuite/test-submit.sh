#!/bin/sh

source test-submit-default.sh
source test-submit-hadoop.sh
source test-submit-hbase.sh
source test-submit-kafka.sh
source test-submit-mahout.sh
source test-submit-phoenix.sh
source test-submit-pig.sh
source test-submit-spark.sh
source test-submit-storm.sh
source test-submit-zookeeper.sh

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
# dependencytests: check dependencies
standardtests=y
dependencytests=y

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

if [ "${defaulttests}" == "y" ]
then
    SubmitDefaultTests
fi

if [ "${hadooptests}" == "y" ]
then
    SubmitHadoopTests
fi

if [ "${hbasetests}" == "y" ]
then
    SubmitHbaseTests
fi

if [ "${kafkatests}" == "y" ]
then
    SubmitKafkaTests
fi

if [ "${mahouttests}" == "y" ]
then
    SubmitMahoutTests
fi

if [ "${phoenixtests}" == "y" ]
then
    SubmitPhoenixTests
fi

if [ "${pigtests}" == "y" ]
then
    SubmitPigTests
fi

if [ "${sparktests}" == "y" ]
then
    SubmitSparkTests
fi

if [ "${stormtests}" == "y" ]
then
    SubmitStormTests
fi

if [ "${zookeepertests}" == "y" ]
then
    SubmitZookeeperTests
fi