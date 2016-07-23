#!/bin/bash

java16="1.6"
java17="1.7"

hadoop2Xjava16versions="2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2"
hadoop2Xjava16versions_javaversion=${java16}
# decommissionhdfsnodes doesn't work reliably in 2.2.X, removing it
hadoop2Xjava16versionsdecommission="2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2"
hadoop2Xjava16versionsdecommission_javaversion=${java16}
hadoop2Xjava17versions="2.6.0 2.6.1 2.6.2 2.6.3 2.6.4 2.7.0 2.7.1 2.7.2"
hadoop2Xjava17versions_javaversion=${java17}

hadoop_test_groups="hadoop2Xjava16versions hadoop2Xjava17versions"
hadoop_test_groups_decommission="hadoop2Xjava16versionsdecommission hadoop2Xjava17versions"
hadoop_all_versions="${hadoop2Xjava16versions} ${hadoop2Xjava17versions}"

mahouthadoop27java17versions="0.11.0 0.11.1 0.11.2 0.12.0 0.12.1 0.12.2"
mahouthadoop27java17versions_hadoopversion="2.7.0"
mahouthadoop27java17versions_javaversion=${java17}

mahout_test_groups="mahouthadoop27java17versions"
mahout_all_versions="${mahouthadoop27java17versions}"

pighadoop26java16versions="0.13.0 0.14.0"
pighadoop26java16versions_hadoopversion="2.6.0"
pighadoop26java16versions_javaversion=${java16}
pighadoop27java17versions="0.15.0 0.16.0"
pighadoop27java17versions_hadoopversion="2.7.0"
pighadoop27java17versions_javaversion=${java17}

pig_test_groups="pighadoop26java16versions pighadoop27java17versions"
pig_all_versions="${pighadoop26java16versions} ${pighadoop27java17versions}"

hbasehadoop26zookeeper34java16versions="0.98.3-hadoop2 0.98.9-hadoop2"
hbasehadoop26zookeeper34java16versions_hadoopversion="2.6.0"
hbasehadoop26zookeeper34java16versions_javaversion=${java16}
hbasehadoop26zookeeper34java16versions_zookeeperversion="3.4.6"
hbasehadoop27zookeeper34java17versions="0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2 1.1.3 1.1.4 1.2.0 1.2.1 1.2.2"
hbasehadoop27zookeeper34java17versions_hadoopversion="2.7.0"
hbasehadoop27zookeeper34java17versions_zookeeperversion="3.4.8"
hbasehadoop27zookeeper34java17versions_javaversion=${java17}

hbase_test_groups="hbasehadoop26zookeeper34java16versions hbasehadoop27zookeeper34java17versions"
hbase_all_versions="${hbasehadoop26zookeeper34java16versions} ${hbasehadoop27zookeeper34java17versions}"

phoenixhbase11hadoop27zookeeper34java17versions="4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1 4.7.0-HBase-1.1"
phoenixhbase11hadoop27zookeeper34java17versions_hbaseversion="1.1.0"
phoenixhbase11hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase11hadoop27zookeeper34java17versions_zookeeperversion="3.4.8"
phoenixhbase11hadoop27zookeeper34java17versions_javaversion=${java17}

phoenix_test_groups="phoenixhbase11hadoop27zookeeper34java17versions"
phoenix_all_versions="${phoenixhbase11hadoop27zookeeper34java17versions}"

spark0Xjava16hadoop2versions="0.9.1-bin-hadoop2 0.9.2-bin-hadoop2"
spark0Xjava16hadoop2versions_hadoopversion="2.2.0"
spark0Xjava16hadoop2versions_javaversion=${java16}
spark1Xjava16hadoop24versions="1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4"
spark1Xjava16hadoop24versions_hadoopversion="2.4.0"
spark1Xjava16hadoop24versions_javaversion=${java16}
spark1Xjava17hadoop26versions="1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6 1.6.2-bin-hadoop2.6"
spark1Xjava17hadoop26versions_hadoopversion="2.6.0"
spark1Xjava17hadoop26versions_javaversion=${java17}

spark_test_groups="spark0Xjava16hadoop2versions spark1Xjava16hadoop24versions spark1Xjava17hadoop26versions"
spark_test_groups_before_1X="spark0Xjava16hadoop2versions"
spark_test_groups_after_1X="spark1Xjava16hadoop24versions spark1Xjava17hadoop26versions"
spark_all_versions="${spark0Xjava16hadoop2versions} ${spark1Xjava16hadoop24versions} ${spark1Xjava17hadoop26versions}"

stormzookeeper34java16versions="0.9.3 0.9.4"
stormzookeeper34java16versions_zookeeperversion="3.4.6"
stormzookeeper34java16versions_javaversion=${java16}
stormzookeeper34java17versions="0.9.5 0.9.6 0.10.0 0.10.1 1.0.0 1.0.1"
stormzookeeper34java17versions_zookeeperversion="3.4.8"
stormzookeeper34java17versions_javaversion=${java17}

storm_test_groups="stormzookeeper34java16versions stormzookeeper34java17versions"
storm_all_versions="${stormzookeeper34java16versions} ${stormzookeeper34java17versions}"

kafkazookeeper34java17versions="2.11-0.9.0.0"
kafkazookeeper34java17versions_zookeeperversion="3.4.8"
kafkazookeeper34java17versions_javaversion=${java17}

kafka_test_groups="kafkazookeeper34java17versions"
kafka_all_versions="${kafkazookeeper34java17versions}"

zookeeperjava17versions="3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.4.5 3.4.6 3.4.7 3.4.8"
zookeeperjava17versions_javaversion=${java17}

zookeeper_test_groups="zookeeperjava17versions"
zookeeper_all_versions="${zookeeperjava17versions}"
