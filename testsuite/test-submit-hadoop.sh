#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitHadoopStandardTests_StandardTerasort() {
    local hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopfullvalidationterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopfullvalidationterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopfullvalidationterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopfullvalidationterasort-no-local-dir
}

SubmitHadoopStandardTests() {
    for testfunction in __SubmitHadoopStandardTests_StandardTerasort
    do
        for testgroup in ${hadoop_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done
}

__SubmitHadoopDependencyTests_Dependency1() {
    local hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
}

__SubmitHadoopDependencyTests_Dependency2() {
    local hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
}

__SubmitHadoopDependencyTests_Dependency3() {
    local hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptterasort
}

__SubmitHadoopDependencyTests_Dependency4() {
    local hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptterasort
}

__SubmitHadoopDependencyTests_Dependency5 () {
    local dependencynumber=$1
    shift
    local silentsuccess=$1
    shift
    local firstversion=$1
    shift
    local restofversions=$@
    
    BasicJobSubmit magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

    for version in ${restofversions}
    do
        DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-older-version-expected-failure
        if [ "${silentsuccess}" == "y" ]
        then
            DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopupgradehdfs-silentsuccess
        else
            DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopupgradehdfs
        fi
        
        DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort
    done
    
    BasicJobSubmit magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort
    
    for version in ${restofversions}
    do
        DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-older-version-expected-failure

        if [ "${silentsuccess}" == "y" ]
        then
            DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopupgradehdfs-silentsuccess
        else
            DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopupgradehdfs
        fi

        DependentJobSubmit magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort
    done
}

__SubmitHadoopDependencyTests_DependencyDetectNewerHDFS() {
    local hadoopversionold=$1
    local hadoopversionnew=$2
    local dependencynumber=$3

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-newer-version-expected-failure
}

SubmitHadoopDependencyTests() {
    for testfunction in __SubmitHadoopDependencyTests_Dependency1 __SubmitHadoopDependencyTests_Dependency2 __SubmitHadoopDependencyTests_Dependency3 __SubmitHadoopDependencyTests_Dependency4
    do
        for testgroup in ${hadoop_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done

    __SubmitHadoopDependencyTests_Dependency5 "5A" "n" 2.4.0 2.5.0 2.6.0 2.7.0 2.8.0 2.9.0 3.0.0
    __SubmitHadoopDependencyTests_Dependency5 "5B" "n" 2.4.0 2.5.0
    __SubmitHadoopDependencyTests_Dependency5 "5C" "n" 2.5.0 2.6.0
    __SubmitHadoopDependencyTests_Dependency5 "5D" "n" 2.6.0 2.7.0
    __SubmitHadoopDependencyTests_Dependency5 "5E" "n" 2.7.0 2.8.0
    __SubmitHadoopDependencyTests_Dependency5 "5F" "n" 2.8.0 2.9.0
    __SubmitHadoopDependencyTests_Dependency5 "5G" "n" 2.9.0 3.0.0

    # Hops between major versions, do jumps of two to avoid permutation growth of tests.
    __SubmitHadoopDependencyTests_Dependency5 "5H" "n" 2.4.0 2.6.0
    __SubmitHadoopDependencyTests_Dependency5 "5I" "n" 2.5.0 2.7.0
    __SubmitHadoopDependencyTests_Dependency5 "5J" "n" 2.6.0 2.8.0
    __SubmitHadoopDependencyTests_Dependency5 "5K" "n" 2.7.0 2.9.0
    __SubmitHadoopDependencyTests_Dependency5 "5L" "n" 2.8.0 3.0.0

    __SubmitHadoopDependencyTests_Dependency5 "5M" "y" 2.4.0 2.4.1
    __SubmitHadoopDependencyTests_Dependency5 "5N" "n" 2.5.0 2.5.1 2.5.2
    __SubmitHadoopDependencyTests_Dependency5 "5O" "n" 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4 2.6.5
    __SubmitHadoopDependencyTests_Dependency5 "5P" "n" 2.7.0 2.7.1 2.7.2 2.7.3 2.7.4 2.7.5
    __SubmitHadoopDependencyTests_Dependency5 "5Q" "n" 2.8.0 2.8.1 2.8.2

    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.2.0" "2.3.0" "6A"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.3.0" "2.4.0" "6B"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.5.0" "6C"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.6.0" "6D"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.7.0" "6E"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.0" "2.8.0" "6F"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.8.0" "2.9.0" "6G"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.9.0" "3.0.0" "6H"
    
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.4.1" "6I"

    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.5.1" "6J"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.1" "2.5.2" "6K"
    
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.6.1" "6L"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.1" "2.6.2" "6M"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.2" "2.6.3" "6N"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.3" "2.6.4" "6O"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.4" "2.6.5" "6P"
    
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.0" "2.7.1" "6Q"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.1" "2.7.2" "6R"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.2" "2.7.3" "6S"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.3" "2.7.4" "6T"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.4" "2.7.5" "6U"

    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.8.0" "2.8.1" "6V"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.8.1" "2.8.2" "6W"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.8.1" "2.8.3" "6X"
}
