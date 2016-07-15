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

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir
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
    for testfunction in __SubmitHadoopDependencyTests_Dependency1
    do
        for testgroup in ${hadoop_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done

    for testfunction in __SubmitHadoopDependencyTests_Dependency2 __SubmitHadoopDependencyTests_Dependency3 __SubmitHadoopDependencyTests_Dependency4
    do
        for testgroup in ${hadoop_test_groups_decommission}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort

    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.2.0" "2.3.0" "6A"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.3.0" "2.4.0" "7A"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.5.0" "8A"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.6.0" "9A"
    __SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.7.0" "10A"
}
