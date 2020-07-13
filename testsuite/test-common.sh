#!/bin/bash

java16="1.6"
java17="1.7"
java18="1.8"

hadoop_decomissionhdfs_minimum="2.3.0"

hadoop2Xjava16versions="2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2"
hadoop2Xjava16versions_javaversion=${java16}
hadoop2Xjava17versions="2.6.0 2.6.1 2.6.2 2.6.3 2.6.4 2.6.5 2.7.0 2.7.1 2.7.2 2.7.3 2.8.0 2.8.1 2.8.2 2.8.3 2.8.4 2.9.0 2.9.1"
hadoop2Xjava17versions_javaversion=${java17}
hadoop2Xjava18versions="2.7.4 2.7.5 2.7.6 2.7.7 2.8.5 2.9.2"
hadoop2Xjava18versions_javaversion=${java18}
hadoop3Xjava18versions="3.0.0 3.0.1 3.0.2 3.0.3 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.2.0 3.2.1 3.2.2 3.3.0 3.3.1"
hadoop3Xjava18versions_javaversion=${java18}

hadoop_test_groups="hadoop2Xjava16versions hadoop2Xjava17versions hadoop2Xjava18versions hadoop3Xjava18versions"
hadoop_all_versions="${hadoop2Xjava16versions} ${hadoop2Xjava17versions} ${hadoop2Xjava18versions} ${hadoop3Xjava18versions}"

pighadoop26java16versions="0.13.0 0.14.0"
pighadoop26java16versions_hadoopversion="2.6.0"
pighadoop26java16versions_javaversion=${java16}
pighadoop27java17versions="0.15.0 0.16.0 0.17.0"
pighadoop27java17versions_hadoopversion="2.7.0"
pighadoop27java17versions_javaversion=${java17}

pig_test_groups="pighadoop26java16versions pighadoop27java17versions"
pig_all_versions="${pighadoop26java16versions} ${pighadoop27java17versions}"

hbasehadoop27zookeeper34java17versions="1.0.0 1.0.1 1.0.1.1 1.0.2 1.0.3 1.1.0 1.1.0.1 1.1.1 1.1.2 1.1.3 1.1.4 1.1.5 1.1.6 1.1.7 1.1.8 1.1.9 1.1.10 1.1.11 1.1.12 1.1.13 1.2.0 1.2.1 1.2.2 1.2.3 1.2.4 1.2.5 1.2.6 1.2.6.1 1.3.0 1.3.1 1.3.2 1.3.2.1 1.4.0 1.4.1 1.4.2 1.4.3 1.4.4 1.4.5 1.4.6 1.4.7 1.4.8 1.4.9"
hbasehadoop27zookeeper34java17versions_hadoopversion="2.7.0"
hbasehadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
hbasehadoop27zookeeper34java17versions_javaversion=${java17}
hbasehadoop27zookeeper34java18versions="1.2.7 1.3.3 1.3.4 1.3.5 1.4.10 1.4.13 1.5.0 1.6.0"
hbasehadoop27zookeeper34java18versions_hadoopversion="2.7.0"
hbasehadoop27zookeeper34java18versions_zookeeperversion="3.4.14"
hbasehadoop27zookeeper34java18versions_javaversion=${java18}

hbase_test_groups="hbasehadoop27zookeeper34java17versions hbasehadoop27zookeeper34java18versions"
hbase_all_versions="${hbasehadoop27zookeeper34java17versions} ${hbasehadoop27zookeeper34java18versions}"

hivehadoop27zookeeper34java17versions="2.3.0"
hivehadoop27zookeeper34java17versions_hadoopversion="2.7.0"
hivehadoop27zookeeper34java17versions_zookeeperversion="3.4.11"
hivehadoop27zookeeper34java17versions_javaversion=${java17}

hive_test_groups="hivehadoop27zookeeper34java17versions"
hive_all_versions="${hivehadoop27zookeeper34java17versions}"

phoenixhbase10hadoop27zookeeper34java17versions="4.5.0-HBase-1.0 4.5.1-HBase-1.0 4.5.2-HBase-1.0 4.6.0-HBase-1.0 4.7.0-HBase-1.0 4.8.0-HBase-1.0 4.8.1-HBase-1.0 4.8.2-HBase-1.0"
phoenixhbase10hadoop27zookeeper34java17versions_hbaseversion="1.0.0"
phoenixhbase10hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase10hadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
phoenixhbase10hadoop27zookeeper34java17versions_javaversion=${java17}

phoenixhbase11hadoop27zookeeper34java17versions="4.5.0-HBase-1.1 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1 4.7.0-HBase-1.1 4.8.0-HBase-1.1 4.8.1-HBase-1.1 4.8.2-HBase-1.1 4.9.0-HBase-1.1 4.10.0-HBase-1.1 4.11.0-HBase-1.1 4.12.0-HBase-1.1 4.13.1-HBase-1.1 4.14.0-HBase-1.1"
phoenixhbase11hadoop27zookeeper34java17versions_hbaseversion="1.1.0"
phoenixhbase11hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase11hadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
phoenixhbase11hadoop27zookeeper34java17versions_javaversion=${java17}

phoenixhbase12hadoop27zookeeper34java17versions="4.8.0-HBase-1.2 4.8.1-HBase-1.2 4.8.2-HBase-1.2 4.9.0-HBase-1.2 4.10.0-HBase-1.2 4.11.0-HBase-1.2 4.12.0-HBase-1.2 4.13.1-HBase-1.2 4.14.0-HBase-1.2"
phoenixhbase12hadoop27zookeeper34java17versions_hbaseversion="1.2.0"
phoenixhbase12hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase12hadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
phoenixhbase12hadoop27zookeeper34java17versions_javaversion=${java17}

phoenixhbase13hadoop27zookeeper34java17versions="4.11.0-HBase-1.3 4.12.0-HBase-1.3 4.13.0-HBase-1.3 4.13.1-HBase-1.3 4.14.0-HBase-1.3"
phoenixhbase13hadoop27zookeeper34java17versions_hbaseversion="1.3.0"
phoenixhbase13hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase13hadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
phoenixhbase13hadoop27zookeeper34java17versions_javaversion=${java17}

phoenixhbase14hadoop27zookeeper34java17versions="4.14.0-HBase-1.4"
phoenixhbase14hadoop27zookeeper34java17versions_hbaseversion="1.4.0"
phoenixhbase14hadoop27zookeeper34java17versions_hadoopversion="2.7.0"
phoenixhbase14hadoop27zookeeper34java17versions_zookeeperversion="3.4.14"
phoenixhbase14hadoop27zookeeper34java17versions_javaversion=${java17}

phoenix_test_groups="phoenixhbase10hadoop27zookeeper34java17versions phoenixhbase11hadoop27zookeeper34java17versions phoenixhbase12hadoop27zookeeper34java17versions phoenixhbase13hadoop27zookeeper34java17versions phoenixhbase14hadoop27zookeeper34java17versions"
phoenix_all_versions="${phoenixhbase10hadoop27zookeeper34java17versions} ${phoenixhbase11hadoop27zookeeper34java17versions} ${phoenixhbase12hadoop27zookeeper34java17versions} ${phoenixhbase13hadoop27zookeeper34java17versions} ${phoenixhbase14hadoop27zookeeper34java17versions}"

spark1Xjava16hadoop23versions="1.1.0-bin-hadoop2.3 1.1.1-bin-hadoop2.3 1.2.0-bin-hadoop2.3 1.2.1-bin-hadoop2.3 1.2.2-bin-hadoop2.3 1.3.0-bin-hadoop2.3 1.3.1-bin-hadoop2.3 1.4.0-bin-hadoop2.3 1.4.1-bin-hadoop2.3"
spark1Xjava16hadoop23versions_hadoopversion="2.3.0"
spark1Xjava16hadoop23versions_javaversion=${java16}
spark1Xjava16hadoop24versions="1.1.0-bin-hadoop2.4 1.1.1-bin-hadoop2.4 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4 1.4.0-bin-hadoop2.4 1.4.1-bin-hadoop2.4"
spark1Xjava16hadoop24versions_hadoopversion="2.4.0"
spark1Xjava16hadoop24versions_javaversion=${java16}
spark1Xjava17hadoop26versions="1.3.1-bin-hadoop2.6 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6 1.6.2-bin-hadoop2.6 1.6.3-bin-hadoop2.6"
spark1Xjava17hadoop26versions_hadoopversion="2.6.0"
spark1Xjava17hadoop26versions_javaversion=${java17}
spark2Xjava17hadoop26versions="2.0.0-bin-hadoop2.6 2.0.1-bin-hadoop2.6 2.0.2-bin-hadoop2.6 2.1.0-bin-hadoop2.6 2.1.1-bin-hadoop2.6 2.1.2-bin-hadoop2.6"
spark2Xjava17hadoop26versions_hadoopversion="2.6.0"
spark2Xjava17hadoop26versions_javaversion=${java17}
spark2Xjava17hadoop27versions="2.0.0-bin-hadoop2.7 2.0.1-bin-hadoop2.7 2.0.2-bin-hadoop2.7 2.1.0-bin-hadoop2.7 2.1.1-bin-hadoop2.7 2.1.2-bin-hadoop2.7"
spark2Xjava17hadoop27versions_hadoopversion="2.7.0"
spark2Xjava17hadoop27versions_javaversion=${java17}
spark2Xjava18hadoop26versions="2.2.0-bin-hadoop2.6 2.2.1-bin-hadoop2.6 2.3.0-bin-hadoop2.6 2.3.1-bin-hadoop2.6 2.3.2-bin-hadoop2.6 2.3.3-bin-hadoop2.6 2.3.4-bin-hadoop2.6 2.4.0-bin-hadoop2.6 2.4.1-bin-hadoop2.6 2.4.2-bin-hadoop2.6 2.4.3-bin-hadoop2.6 2.4.4-bin-hadoop2.6 2.4.5-bin-hadoop2.6 2.4.6-bin-hadoop2.6 2.4.7-bin-hadoop2.6 2.4.8-bin-hadoop2.6"
spark2Xjava18hadoop26versions_hadoopversion="2.6.0"
spark2Xjava18hadoop26versions_javaversion=${java18}
spark2Xjava18hadoop27versions="2.2.0-bin-hadoop2.7 2.2.1-bin-hadoop2.7 2.3.0-bin-hadoop2.7 2.3.1-bin-hadoop2.7 2.3.2-bin-hadoop2.7 2.3.3-bin-hadoop2.7 2.3.4-bin-hadoop2.7 2.4.0-bin-hadoop2.7 2.4.1-bin-hadoop2.7 2.4.2-bin-hadoop2.7 2.4.3-bin-hadoop2.7 2.4.4-bin-hadoop2.7 2.4.5-bin-hadoop2.7 2.4.6-bin-hadoop2.7 2.4.7-bin-hadoop2.7 2.4.8-bin-hadoop2.7"
spark2Xjava18hadoop27versions_hadoopversion="2.7.0"
spark2Xjava18hadoop27versions_javaversion=${java18}
spark3Xjava18hadoop27versions="3.0.0-bin-hadoop2.7 3.0.1-bin-hadoop2.7 3.0.2-bin-hadoop2.7 3.0.3-bin-hadoop2.7"
spark3Xjava18hadoop27versions_hadoopversion="2.7.0"
spark3Xjava18hadoop27versions_javaversion=${java18}
spark3Xjava18hadoop32versions="3.0.0-bin-hadoop3.2 3.0.1-bin-hadoop3.2 3.0.2-bin-hadoop3.2 3.0.3-bin-hadoop3.2"
spark3Xjava18hadoop32versions_hadoopversion="3.2.0"
spark3Xjava18hadoop32versions_javaversion=${java18}

spark_test_groups="spark1Xjava16hadoop23versions spark1Xjava16hadoop24versions spark1Xjava17hadoop26versions spark2Xjava17hadoop26versions spark2Xjava17hadoop27versions spark2Xjava18hadoop26versions spark2Xjava18hadoop27versions spark3Xjava18hadoop27versions spark3Xjava18hadoop32versions"
spark_all_versions="${spark1Xjava16hadoop23versions} ${spark1Xjava16hadoop24versions} ${spark1Xjava17hadoop26versions} ${spark2Xjava17hadoop26versions} ${spark2Xjava17hadoop27versions} ${spark2Xjava18hadoop26versions} ${spark2Xjava18hadoop27versions} ${spark3Xjava18hadoop27versions} ${spark3Xjava18hadoop32versions}"

stormzookeeper34java16versions="0.9.3 0.9.4"
stormzookeeper34java16versions_zookeeperversion="3.4.6"
stormzookeeper34java16versions_javaversion=${java16}
stormzookeeper34java17versions="0.9.5 0.9.6 0.9.7 0.10.0 0.10.1 0.10.2 1.0.0 1.0.1 1.0.2 1.0.3 1.0.4 1.1.0 1.1.1 1.1.2 1.2.0 1.2.1 1.2.2"
stormzookeeper34java17versions_zookeeperversion="3.4.14"
stormzookeeper34java17versions_javaversion=${java17}
stormzookeeper34java18versions="1.2.3"
stormzookeeper34java18versions_zookeeperversion="3.4.14"
stormzookeeper34java18versions_javaversion=${java18}

storm_test_groups="stormzookeeper34java16versions stormzookeeper34java17versions stormzookeeper34java18versions"
storm_all_versions="${stormzookeeper34java16versions} ${stormzookeeper34java17versions} ${stormzookeeper34java18versions}"

kafkazookeeper34java17versions="2.11-0.9.0.0"
kafkazookeeper34java17versions_zookeeperversion="3.4.14"
kafkazookeeper34java17versions_javaversion=${java17}

kafka_test_groups="kafkazookeeper34java17versions"
kafka_all_versions="${kafkazookeeper34java17versions}"

zookeeperjava17versions="3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.4.5 3.4.6 3.4.7 3.4.8 3.4.9 3.4.10 3.4.11 3.4.12 3.4.13"
zookeeperjava17versions_javaversion=${java17}
zookeeperjava18versions="3.4.14"
zookeeperjava18versions_javaversion=${java18}

zookeeper_test_groups="zookeeperjava17versions zookeeperjava18versions"
zookeeper_all_versions="${zookeeperjava17versions} ${zookeeperjava18versions}"

zeppelinspark16java17versions="0.6.0 0.6.1 0.6.2 0.7.0 0.7.1 0.7.2 0.7.3"
zeppelinspark16java17versions_sparkversion="1.6.0-bin-hadoop2.6"
zeppelinspark16java17versions_javaversion="${java17}"
zeppelinspark16java18versions="0.8.0 0.8.1 0.8.2"
zeppelinspark16java18versions_sparkversion="1.6.0-bin-hadoop2.6"
zeppelinspark16java18versions_javaversion="${java18}"

zeppelin_test_groups="zeppelinspark16java17versions zeppelinspark16java18versions"
zeppelin_all_versions="${zeppelinspark16java17versions} ${zeppelinspark16java18versions}"

alluxiojava18versions="2.3.0"
alluxiojava18versions_javaversion=${java18}

alluxio_test_groups="alluxiojava18versions"
alluxio_all_versions="${alluxiojava18versions}"
