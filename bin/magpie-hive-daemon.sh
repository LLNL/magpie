#!/bin/bash
#############################################################################
#  Copyright (C) 2013-2015 Lawrence Livermore National Security, LLC.
#  Produced at Army Research Laboratory, APG MD  (cf, DISCLAIMER).
#  Written by Adam Childs <adam.s.childs.ctr@mail.mil>
#  LLNL-CODE-644248
#  
#  This file is part of Magpie, scripts for running Hadoop on
#  traditional HPC systems.  For details, see https://github.com/llnl/magpie.
#  
#  Magpie is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  Magpie is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with Magpie.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

# This script launches Hive for the user

# First argument is path to Hive Configuration directory

# Second argument is path to Hive binary

# Third argument is start or stop

if [ "$1X" == "X" ]
then
    echo "User must specify Hive configuration path"
    exit 1
fi

if [ ! -d $1 ]
then
    echo "Hive configuration path is not a directory"
fi

if [ "$2X" == "X" ]
then
    echo "User must specify path to Hive as second argument"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "Hive path is not a directory"
fi

if [ "$3X" == "X" ]
then
    echo "User must specify start or stop as third argument"
    exit 1
fi

if [ "$3" != "start" ] && [ "$3" != "stop" ]
then
    echo "User must specify start or stop as third argument"
    exit 1
fi

# source the hive-env.sh file
source $1/hive-env.sh
myhostname=`hostname`

if [ "$3" == "start" ]
then
    if [ -f "${HIVE_PID_DIR}/hive-metastore.pid" ]
    then
        echo "Hive metastore pid file found, it should already be running"
    else
        if [ "${HIVE_METASTORE_DIR}X" != "X" ]
        then
            hivemetastoredir=${HIVE_METASTORE_DIR}
        else
            hivemetastoredir="${hivelocalscratchdirpath}/hive/database/postgres/data"
        fi
        
        # check for the metastore warehouse directory, if not present create it.
        if [ ! -d $HIVE_METASTORE_DIR ]
        then
            echo "Metastore warehouse directory ( ${HIVE_METASTORE_DIR} ) not found, creating directory now."
            mkdir -p $HIVE_METASTORE_DIR

            if [ ! -d $HIVE_METASTORE_DIR ] 
            then
                echo "Failed to create metastore warehouse directory at ${HIVE_METASTORE_DIR}! Unable to continue."
                exit 1
            fi
        fi

        echo "Starting Hive Metastore on ${myhostname}"

        $2/bin/hive --service metastore &> ${HIVE_LOG_DIR}/metastore_service.log &
        scriptpid=$!
        echo $scriptpid > ${HIVE_PID_DIR}/hive-metastore.pid
        sleep 5
        
        export PATH=${PATH}:$2/bin
        echo "Checking Hive Metastore settings"

        # This will verify the NameNode location for the metastore, and if necessary update it to the correct node.
        # EX: metastore was created/started on NODE-01 and was shut down, then brought back up on NODE-02.  metastore NameNode URI will contain hdfs://NODE-01/database 
        # and NODE-02 will not connect properly.
        # -listFSRoot finds and compares the NameNode in the metstore to the current node.  If necessary the -updateLocation function is called.
        # $HIVE_HOME/bin/metatool -updateLocation <new location> <old location>  <-- this updates the metastore to the current NameNode
        # EX: $HIVE_HOME/bin/metatool -updateLocation hdfs://n030:54310/path/to/metastore/database.db hdfs://n034:54310/path/to/metastore/database.db

        fsroot=`${2}/bin/metatool -listFSRoot | grep 'hdfs://'`
        hiveneedspathupdate=0

        for line in `echo $fsroot`; do
            fshost=`echo "${line}"|cut -d / -f 3`
            IFS=':' read -r -a tmparr <<<"$fshost"
            name="${tmparr[0]}"
            port="${tmparr[1]}"

            if [[ "$name" != "$myhostname" ]]; then
                hiveneedspathupdate=1
                echo "Metastore reports ${fshost}, attempting to update to ${myhostname}"
                newfshost="${line/$name/$myhostname}"
                $2/bin/metatool -updateLocation ${newfshost} ${line}
            fi
        done
    fi

    metastorechk=`ps aux | grep '[H]iveMetaStore' | awk '{print $2}'`
    if [ "${metastorechk}X" == "X" ]
    then
        echo "Hive Metastore failed to start! Unable to continue"
        exit 1
    fi

    if [ -f "${HIVE_PID_DIR}/hive-server.pid" ]
    then
        echo "Hive server pid file found, it should already be running"
    else
        echo "Starting Hive server on ${myhostname}"

        ${2}/bin/hive --service hiveserver2 &> ${HIVE_LOG_DIR}/hiveserver_service.log &
        scriptpid=$!
        echo $scriptpid > ${HIVE_PID_DIR}/hive-server.pid
        
        sleep 10

        connattemptcount=0
        while [ $connattemptcount -lt 5 ]
        do
            connattemptcount=$[$connattemptcount+1]
            dbcheck=`${2}/bin/beeline -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT} -e 'show databases;'`
            chkret=$?
            if [ $chkret -ne 0 ]; then
                echo "Connection attempt ${connattemptcount} of 5 failed.  Retrying in 10 seconds"
                sleep 10
            else
                echo "Successful connection to Hive server"
                break 
            fi
        done 
            
        if [ $connattemptcount -eq 5 ]; then
            echo "Unsuccessful connecting to Hive 5 times.  Exiting."
            exit 1
        fi 
        
        dbcheck=`echo ${dbcheck} |grep ${HIVE_DB_NAME}`

        # Check to see if the HIVE_DB_NAME database exists.  If not, create it.
 
        if [ "${dbcheck}X" == "X" ]
        then
            echo "${HIVE_DB_NAME} not found, creating it now."
            echo "create database if not exists ${HIVE_DB_NAME};" >> ${HIVE_LOCAL_SCRATCHSPACE_DIR}/createdb.sql

            ${2}/bin/beeline --showHeader=false -u jdbc:hive2://${HIVE_MASTER_NODE}:${HIVE_PORT} -f ${HIVE_LOCAL_SCRATCHSPACE_DIR}/createdb.sql

            chkret=$?
            if [ $chkret -ne 0 ]; then
                echo "Creation of ${HIVE_DB_NAME} failed!"
                exit 1
            fi 
            rm ${HIVE_LOCAL_SCRATCHSPACE_DIR}/createdb.sql
        fi
       
        # Check to see if the PATH property in the SERDEPROPERTIES for the tables needs to be updated 
        if [ $hiveneedspathupdate -ne 0 ]; then
            ${MAGPIE_SCRIPTS_HOME}/bin/magpie-hive-update-table-paths.sh
        fi
    fi
else
    # No nice way to do this, other than to find and kill the Hive and Metastore PIDs
    # take the Metastore down first.  If Hive can't write to the Metastore, any process still active
    # should fail, but won't cause harm to the DB.  
    if [ -f "${HIVE_PID_DIR}/hive-metastore.pid" ]
    then
        scriptpid=`cat ${HIVE_PID_DIR}/hive-metastore.pid`
        echo "Killing Hive metastore pid $scriptpid on $myhostname"
        kill -9 $scriptpid
        rm -f ${HIVE_PID_DIR}/hive-metastore.pid
    else
        echo "Cannot find pid file ${HIVE_PID_DIR}/hive-metastore.pid"
    fi

    if [ -f "${HIVE_PID_DIR}/hive-server.pid" ]
    then
        scriptpid=`cat ${HIVE_PID_DIR}/hive-server.pid`
        echo "Killing Hive server pid $scriptpid on $myhostname"
        kill -9 $scriptpid
        rm -f ${HIVE_PID_DIR}/hive-server.pid
    else
        echo "Cannot find pid file ${HIVE_PID_DIR}/hive-server.pid"
    fi
fi

