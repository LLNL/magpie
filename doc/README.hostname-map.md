Magpie Hostname Map
-------------------

Generally speaking, Magpie assumes that the:

1) the nodenames output from the scheduler/resource manager after a
   job is allocated (e.g. foo[0-4]) are the addresses/hostnames that
   should be configured into Hadoop, Spark, etc.

2) the output of the 'hostname' command also maps to the nodenames
   output from the scheduler/resource manager.

However, there are circumstances where this is not the case.

For example, perhaps the 'hostname' command outputs the fully
qualified domain name of a server and not the shortened hostname,
which a scheduler is configured to.

Or, perhaps the nodes in a scheduler/resource manager are configured
to the management network and not the high speed interconnect of a
cluster.

Beginning with Magpie 2.0, two options MAGPIE_HOSTNAME_CMD_MAP and
MAGPIE_HOSTNAME_SCHEDULER_MAP allow users to specify a script to map
the hostname from the hostname cmd or scheduler to a new value.

The submission scripts do not include these configuration fields by
default. To include them:

```
cd submission-scripts/script-templates
edit Makefile and set MAGPIE_HOSTNAME_MAP to 'y'
run 'make'
```
