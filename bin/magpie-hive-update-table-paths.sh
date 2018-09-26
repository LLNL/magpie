#!/bin/bash
#  This updates the PATH setting for Hive tables that have become 'disconnected'
#  EX if Hive is running on Node1 and did not update from Node2 it would correct that scenario.
#
#  This must be run from the node where HiveServer is running, after sourcing the magpie-env.sh.  


if [ "${HIVE_CONF_DIR}X" == "X" ]
then
    echo "Path to HIVE_CONF_DIR not found, source magpie-env.sh and re-try."
    exit 1
fi

source $HIVE_CONF_DIR/hive-env.sh

if [ "${HIVE_HOME}X" == "X" ]
then
    echo "Path to HIVE_HOME not found, source magpie-env.sh and re-try."
    exit 1
fi

if [ "${HIVE_LOCAL_SCRATCHSPACE_DIR}X" == "X" ]
then
    echo "Path to HIVE_LOCAL_SCRATCHSPACE_DIR not found, source magpie-env.sh and re-try."
    exit 1
fi

export PATH=$PATH:$HIVE_HOME/bin

curhost=`hostname`
dateprefix=`date +%F`

echo "Getting table data..."

listofdbs=`beeline -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT} -e 'show databases;'|grep '| ' | awk '{print $2}' `
for db in `echo $listofdbs`; do
    # filter out the 'database_name' header
    if [[ "$db" != "database_name" ]]; then
        echo "Querying ${db} tables..."
        tabledata=`beeline -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT}/${db} -e 'show tables;' |grep '| ' | awk '{print $2}'`
        
        for table in `echo $tabledata`; do
        # this filters out the 'tab_name' header in the sql response
            if [[ "$table" != "tab_name" ]]; then
                echo "describe formatted ${table};" >> ${HIVE_LOCAL_SCRATCHSPACE_DIR}/${dateprefix}_${db}_descr_formatted_tables.sql
            fi
        done

        # We need to grab the path too, possible that they're located at a different location on a different server
        tablepaths=`beeline -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT}/${db} -f ${HIVE_LOCAL_SCRATCHSPACE_DIR}/${dateprefix}_${db}_descr_formatted_tables.sql |grep 'path'`
         
        # check for values in tablepaths, it is possible to have no paths to update
        if [ -n "$tablepaths" ]; then
            for path in `echo $tablepaths`; do
            # see if the path variable has hdfs:// in it so no 'junk' ends up in the .sql file
                if [[ $path = *"hdfs://"* ]]; then
                    # grab the table name from the end of the path
                    curtable="${path##*/}"
                    #replace the old node name with the new one in the path 
                    newpath=$(echo $path | sed -e "s/fob-n[0-9]\+/${curhost}/g")
                    echo "Updating OLD: ${path} to NEW: ${newpath}" >> ${HIVE_LOG_DIR}/hive-update-table-paths.log
                    echo "ALTER TABLE ${curtable} SET SERDEPROPERTIES ('path'='${newpath}');" >> ${HIVE_LOCAL_SCRATCHSPACE_DIR}/${dateprefix}_${db}_update_hive_path.sql
                fi
            done
            beeline -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT}/${db} -f ${HIVE_LOCAL_SCRATCHSPACE_DIR}/${dateprefix}_${db}_update_hive_path.sql
        fi
    fi
done


