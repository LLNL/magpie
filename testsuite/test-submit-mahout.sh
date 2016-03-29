#!/bin/sh

SubmitMahoutTests() {

    if [ "${mahouttests}" == "y" ]
    then
	if [ "${standardtests}" == "y" ]
	then
	    for mahoutversion in 0.11.0 0.11.1
	    do
		for hadoopversion in 2.7.0
		do
                    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
		    
                    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir
		done
	    done
	fi

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

}