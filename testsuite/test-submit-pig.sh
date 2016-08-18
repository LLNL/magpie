#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitPigStandardTests_Common() {
    local pigversion=$1
    local hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript-no-local-dir
}

SubmitPigStandardTests() {
    for testfunction in __SubmitPigStandardTests_Common
    do
        for testgroup in ${pig_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion}
            done
        done
    done
}

__SubmitPigDependencyTests_Dependency1() {
    local pigversion=$1
    local hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-no-copy-run-pigscript

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-no-copy-run-pigscript
}

SubmitPigDependencyTests() {
    for testfunction in __SubmitPigDependencyTests_Dependency1
    do
        for testgroup in ${pig_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion}
            done
        done
    done
}