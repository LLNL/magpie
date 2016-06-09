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

# Toggle y/n for different test types
# standardtests: not using MAGPIE_NO_LOCAL_DIR
# dependencytests: check dependencies
standardtests=y
dependencytests=y
regressiontests=y

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

if [ "${standardtests}" == "y" ]
then
    SubmitDefaultStandardTests
fi
# if [ "${dependencytests}" == "y" ]
# then
# 	SubmitDefaultDependencyTests
# fi
if [ "${regressiontests}" == "y" ]
then
    SubmitDefaultRegressionTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitHadoopStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitHadoopDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitPigStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitPigDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitMahoutStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitMahoutDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitHbaseStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitHbaseDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitPhoenixStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitPhoenixDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitSparkStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitSparkDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitStormStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitStormDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitKafkaStandardTests
fi
if [ "${dependencytests}" == "y" ]
then
    SubmitKafkaDependencyTests
fi

if [ "${standardtests}" == "y" ]
then
    SubmitZookeeperStandardTests
fi
# if [ "${dependencytests}" == "y" ]
# then
# 	SubmitZookeeperDependencyTests
# fi
