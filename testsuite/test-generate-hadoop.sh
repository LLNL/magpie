#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source ../magpie/lib/magpie-lib-helper

__GenerateHadoopStandardTests_StandardTerasort() {
    local hadoopversion=$1
    local javaversion=$2

# Note, b/c of MAPREDUCE-5528, not testing rawnetworkfs w/ terasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort
    
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir
        
    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
    
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*
    
    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-single-path*
    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

    sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*
    
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*
    
    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-single-path*
    
    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*
    
    sed -i -e 's/# export HADOOP_LOCALSTORE_CLEAR="\(.*\)"/export HADOOP_LOCALSTORE_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-${hadoopversion}*`
}

GenerateHadoopStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hadoop Standard Tests"

    for testfunction in __GenerateHadoopStandardTests_StandardTerasort
    do
        for testgroup in ${hadoop_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!javaversion}
            done
        done
    done
}

__GenerateHadoopDependencyTests_Dependency1() {
    local hadoopversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
        
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*`
}

__GenerateHadoopDependencyTests_Dependency2_requiredecommissionhdfs() {
    local hadoopversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    
    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A*hdfsoverlustre*
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop2A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A*hdfsovernetworkfs*
    
    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A*decommissionhdfsnodes*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A*`
}

__GenerateHadoopDependencyTests_Dependency3_requiredecommissionhdfs() {
    local hadoopversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptteragen
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptteragen
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsovernetworkfs*
    
    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
        -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hadoopteragen.sh"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*scriptteragen*

    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
        -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hadoopterasort.sh"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*scriptterasort*

    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*decommissionhdfsnodes*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*`
}

__GenerateHadoopDependencyTests_Dependency4_requiredecommissionhdfs() {
    local hadoopversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsovernetworkfs*
    
    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
        -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hadoopteragen.sh"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptteragen*

    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
        -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hadoopterasort.sh"/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptterasort*

    sed -i \
        -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*decommissionhdfsnodes*
        
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*`
}

__GenerateHadoopDependencyTests_Dependency5 () {
    local dependencynumber=$1
    shift
    local silentsuccess=$1
    shift
    local firstversion=$1
    shift
    local restofversions=$@
    
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${firstversion}"'"/' \
        magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}*run-hadoopterasort

    # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
    Magpie_vercomp ${firstversion} "2.6.0"
    if [ $? == "2" ]; then
        JavaCommonSubstitution ${java16} `ls magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}*`
    else
        JavaCommonSubstitution ${java17} `ls magpie.${submissiontype}-hadoop-${firstversion}-DependencyHadoop${dependencynumber}*`
    fi

    for version in ${restofversions}
    do
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-older-version-expected-failure
        if [ "${silentsuccess}" == "y" ]
        then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopupgradehdfs-silentsuccess
        else
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopupgradehdfs
        fi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-older-version-expected-failure
        if [ "${silentsuccess}" == "y" ]
        then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopupgradehdfs-silentsuccess
        else
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopupgradehdfs
        fi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort

        sed -i \
            -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${version}"'"/' \
            magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}*

        sed -i \
            -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
            magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}*run-hadoopupgradehdfs*

        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${version} "2.6.0"
        if [ $? == "2" ]; then
            JavaCommonSubstitution ${java16} `ls magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}*`
        else
            JavaCommonSubstitution ${java17} `ls magpie.${submissiontype}-hadoop-${version}-DependencyHadoop${dependencynumber}*`
        fi
    done
    
    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop*DependencyHadoop${dependencynumber}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop*DependencyHadoop${dependencynumber}*hdfsovernetworkfs*
}

__GenerateHadoopDependencyTests_DependencyDetectNewerHDFS() {
    local hadoopversionold=$1
    local hadoopversionnew=$2
    local javaversionold=$3
    local javaversionnew=$4
    local dependencynumber=$5

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversionnew}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

    JavaCommonSubstitution ${javaversionnew} magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversionold}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-newer-version-expected-failure

    JavaCommonSubstitution ${javaversionold} magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-newer-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversionnew}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort

    JavaCommonSubstitution ${javaversionnew} magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversionold}"'"/' \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop'"${dependencynumber}"'\/"/' \
        magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    JavaCommonSubstitution ${javaversionold} magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-newer-version-expected-failure
}

GenerateHadoopDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hadoop Dependency Tests"

# Dependency Tests for Hadoop

# Dependency 1 Tests, run after another
# Dependency 2 test, increase & decrease size
# Dependency 3 test, ensure data exists between runs, including increase node size and decrease node size
# Dependency 4 test, ensure data exists between runs, decommission data filled blocks

    for testfunction in __GenerateHadoopDependencyTests_Dependency1 __GenerateHadoopDependencyTests_Dependency2_requiredecommissionhdfs __GenerateHadoopDependencyTests_Dependency3_requiredecommissionhdfs __GenerateHadoopDependencyTests_Dependency4_requiredecommissionhdfs
    do
        for testgroup in ${hadoop_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                CheckForHadoopDecomissionMinimum ${testfunction} "Hadoop" "Hadoop" ${testversion} ${hadoop_decomissionhdfs_minimum}
                ${testfunction} ${testversion} ${!javaversion}
            done
        done
    done

# Dependency 5 tests, upgrade hdfs, e.g. 2.4.0 -> 2.5.0 -> 2.6.0 -> 2.7.0, HDFS over Lustre / NetworkFS
# - hadoop 2.4.X does not have "Finalize upgrade success" phrase output when complete

    # All of the major versions
    __GenerateHadoopDependencyTests_Dependency5 "5A" "n" 2.4.0 2.5.0 2.6.0 2.7.0
    # Between consecutive major versions
    __GenerateHadoopDependencyTests_Dependency5 "5B" "n" 2.4.0 2.5.0
    __GenerateHadoopDependencyTests_Dependency5 "5C" "n" 2.5.0 2.6.0
    __GenerateHadoopDependencyTests_Dependency5 "5D" "n" 2.6.0 2.7.0
    # Hops between major versions
    __GenerateHadoopDependencyTests_Dependency5 "5E" "n" 2.4.0 2.6.0
    __GenerateHadoopDependencyTests_Dependency5 "5F" "n" 2.4.0 2.7.0
    __GenerateHadoopDependencyTests_Dependency5 "5G" "n" 2.5.0 2.7.0
    # Between minor versions
    __GenerateHadoopDependencyTests_Dependency5 "5H" "y" 2.4.0 2.4.1
    __GenerateHadoopDependencyTests_Dependency5 "5I" "n" 2.5.0 2.5.1 2.5.2
    __GenerateHadoopDependencyTests_Dependency5 "5J" "n" 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    __GenerateHadoopDependencyTests_Dependency5 "5K" "n" 2.7.0 2.7.1 2.7.2

# Dependency 6 test, detect newer hdfs version X from Y, HDFS over Lustre / NetworkFS

    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.2.0" "2.3.0" ${java16} ${java16} "6A"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.3.0" "2.4.0" ${java16} ${java16} "6B"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.5.0" ${java16} ${java16} "6C"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.6.0" ${java16} ${java17} "6D"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.7.0" ${java17} ${java17} "6E"

    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.4.1" ${java16} ${java16} "6F"
    
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.5.1" ${java16} ${java16} "6G"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.1" "2.5.2" ${java16} ${java16} "6H"

    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.6.1" ${java17} ${java17} "6I"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.1" "2.6.2" ${java17} ${java17} "6J"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.2" "2.6.3" ${java17} ${java17} "6K"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.3" "2.6.4" ${java17} ${java17} "6L"

    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.0" "2.7.1" ${java17} ${java17} "6M"
    __GenerateHadoopDependencyTests_DependencyDetectNewerHDFS "2.7.1" "2.7.2" ${java17} ${java17} "6N"
}

GenerateHadoopPostProcessing() {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-hadoopterasort*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hadoopterasort-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*run-scriptteragen*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scriptteragen-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*run-scriptterasort*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scriptterasort-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hadoopupgradehdfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs*silentsuccess*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/silentsuccess-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*decommissionhdfsnodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/decommissionhdfsnodes-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-fewer-nodes-expected-failure-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*hdfs-older-version*expected-failure*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-older-version-expected-failure-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*hdfs-newer-version*expected-failure*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-newer-version-expected-failure-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-more-nodes-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*" | grep -v Dependency`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export HADOOP_PER_JOB_HDFS_PATH="\(.*\)"/export HADOOP_PER_JOB_HDFS_PATH="yes"/' ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my node count>/${basenodesmorenodescount}/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*hdfs-fewer-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my node count>/${basenodescount}/" ${files}
    fi
}
