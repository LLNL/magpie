#!/bin/sh

SubmitPigTests() {
    if [ "${standardtests}" == "y" ]
    then
	for pigversion in 0.12.0 0.12.1
	do
	    for hadoopversion in 2.4.0
	    do
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript

                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
	    done
	done
	
	for pigversion in 0.13.0 0.14.0
	do
	    for hadoopversion in 2.6.0
	    do
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript

                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
	    done
	done
	
	for pigversion in 0.15.0
	do
	    for hadoopversion in 2.7.0
	    do
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript

                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
                BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
	    done
	done
    fi

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
}
