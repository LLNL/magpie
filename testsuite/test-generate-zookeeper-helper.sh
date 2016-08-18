#!/bin/bash

source test-common.sh
source test-config.sh

SetupZookeeperLocal() {
    local files=$@
    
    sed -i \
        -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="\(.*\)"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' \
        -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' \
        ${files}
}

SetupZookeeperNetworkFS() {
    local files=$@
    
    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
        ${files}
}

SetupZookeeperNotShared() {
    local files=$@
    
    sed -i \
        -e 's/# export ZOOKEEPER_SHARE_NODES=\(.*\)/export ZOOKEEPER_SHARE_NODES=no/' \
        ${files}
}

SetupZookeeperShared() {
    local files=$@
    
    sed -i \
        's/# export ZOOKEEPER_SHARE_NODES=\(.*\)/export ZOOKEEPER_SHARE_NODES=yes/' \
        ${files}
}

SetupZookeeperNetworkFSDependency() {
    local dependencystr=$1
    shift
    local projectversion=$1
    shift
    local filesystem=$1
    shift
    local files=$@

    sed -i \
        -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
        -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/'"${filesystem}"'\/'"${dependencystr}"'\/'"${projectversion}"'"/' \
        ${files}
}
