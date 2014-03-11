#!/bin/sh

# This script scans the specified table.  Use should set the
# mytable variable at the top of the file.
#
# Add extra scanner specifications in mytablespecs.
#
# Examples (per Hbase help)
#
# hbase> scan '.META.'
# hbase> scan '.META.', {COLUMNS => 'info:regioninfo'}
# hbase> scan 't1', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}

mytable="inserttablename"
# example mytablespecs="{STARTROW => '00000000000000000000140455', LIMIT => 1000}"
mytablespecs=""

cd ${HBASE_HOME}

command="echo scan '${mytable}'"
if [ "${mytablespecs}X" != "X" ]
then
    command="$command, ${mytablespecs}"
fi

echo "Running $command in hbase shell" >&2
$command | bin/hbase shell

exit 0