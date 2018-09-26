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

# This script launches Postgres for the user

# First argument is start or stop

# Second argument is the path to Hive configuration directory

if [ "$1X" == "X" ]
then
    echo "User must specify start or stop as first argument"
    exit 1
fi

if [ "$1" != "start" ] && [ "$1" != "stop" ]
then
    echo "User must specify start or stop as first argument"
    exit 1
fi

if [ "$2X" == "X" ]
then
    echo "User must specify Hive configuration path as second argument"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "Hive configuration path is not a directory"
    exit 1
fi

# source the hive-env.sh file
source $2/hive-env.sh
myhostname=`hostname`

if [ "$1" == "start" ]
then
  if [ ! -d $PGDATA ]
  then
    echo "${PGDATA} not found!  Initializing under the assumption that this is a new instance"
    mkdir -p $PGDATA

    if [ ! -d $PGDATA ]
    then
        echo "Unable to create ${PGDATA}, postgres cannot start."
        exit 1
    fi 

    echo "Initializing PostgreSQL database cluster under ${PGDATA}"
    $POSTGRES_HOME/bin/pg_ctl initdb

    # Postgres must be running for the schematool to be successful
    $POSTGRES_HOME/bin/pg_ctl start -l $HIVE_LOG_DIR/postgres.log -w -s
    while ! grep -q "database system is ready to accept connections" ${HIVE_LOG_DIR}/postgres.log
    do
        echo "Waiting for Postgres to complete startup"
        sleep 5
    done

    # create the DB
    $POSTGRES_HOME/bin/createdb $HIVE_DB_NAME

    # create the hiveuser for postgres
    $POSTGRES_HOME/bin/createuser -s hiveuser

    #run the schemaTool to initialize the Hive schema
    $HIVE_HOME/bin/schematool -dbType postgres -initSchema

    $POSTGRES_HOME/bin/pg_ctl stop
    sleep 5

    # copy the updated .conf file to the PGDATA directory
    cp $HIVE_CONF_DIR/postgresql.conf $PGDATA/postgresql.conf

    # Postgres must be running for the schematool to be successful
    $POSTGRES_HOME/bin/pg_ctl start -l $HIVE_LOG_DIR/postgres.log -w -s
    while ! grep -q "database system is ready to accept connections" ${HIVE_LOG_DIR}/postgres.log
    do
        echo "Waiting for Postgres to complete startup"
        sleep 5
    done
else
    # check for PGDATA permissions, if GROUP permissions exist Postgres fails to start
    pgdataperms=`stat ${PGDATA} | sed -n "/^Access: (/{s/Access: (\([0-9]\+\).*$/\1/;p}"`
    if [[ $pgdataperms != 0700 ]]
    then
      echo "Permissions on ${PGDATA} are set for group access.  Setting to 0700 for Postgres functionality"
      chmod u+rwX,g-rwxs,o-rwxs $PGDATA
      pgdatacheck=`stat ${PGDATA} | sed -n "/^Access: (/{s/Access: (\([0-9]\+\).*$/\1/;p}"`
      if [[ $pgdatacheck != 0700 ]]
      then 
        echo "Unable to alter permissions for ${PGDATA}!  Postgres will not start!"
        exit 1
      else 
        echo "${PGDATA} permissions updated."
      fi
    fi
    echo "Starting Postgres on ${myhostname} for Hive"

    # copy the updated .conf file to the PGDATA directory
    cp $HIVE_CONF_DIR/postgresql.conf $PGDATA/postgresql.conf

    $POSTGRES_HOME/bin/pg_ctl start -l $HIVE_LOG_DIR/postgres.log -w -s
    while ! grep -q "database system is ready to accept connections" ${HIVE_LOG_DIR}/postgres.log
    do
        echo "Waiting for Postgres to complete startup"
        sleep 5
    done
  fi
else
    #stop postgres
    $POSTGRES_HOME/bin/pg_ctl stop
    while ! grep -q "database system is shut down" ${HIVE_LOG_DIR}/postgres.log
    do 
        echo "Waiting for Postgres to shut down"
        sleep 5
    done
fi
