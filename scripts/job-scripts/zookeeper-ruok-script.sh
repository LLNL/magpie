#!/bin/sh

# This script just checks if Zookeeper was setup on the nodes you wanted 
#

zookeepernodes=`cat ${ZOOKEEPER_CONF_DIR}/zookeeper_slaves`

for zookeepernode in ${zookeepernodes}
do
    echo "Sending ruok to ${zookeepernode} ... "
    echo ruok | nc ${zookeepernode} 2181
    echo 
done

exit 0
