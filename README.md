magpie
======

This project contains a number of scripts for running Big Data
software in HPC environments.  Thus far, Hadoop, Hbase, Pig, Spark,
Storm, and Zookeeper are supported.  It currently supports running
over the schedulers/resource managers of Slurm and Moab.  It currently
supports running over the parallel file system Lustre and running over
any generic network filesytem.

Basic Idea
----------

The basic idea behind these scripts are to:

1) Allocate nodes on a cluster using your HPC scheduler/resource
   manager.  Slurm and Moab are currently supported.

2) Scripts will setup configuration files so the rank 0 node is
   the "master".  All compute nodes will have configuration files
   created that point to the node designated as the master server.

   The configuration files will be populated with values for your
   filesystem choice and the hardware that exists in your cluster.
   Reasonable attempts are made to determine optimal values (they are
   almost certainly better than the default values).

3) Launch daemons on all nodes.  The rank 0 node will run master
   daemons, such as the Hadoop Namenode or the Hbase Master.  All
   remaining nodes will run appropriate slave daemons, such as the
   Hadoop Datanodes or Hbase RegionServers.

4) Now you have a mini cluster to do whatever you want.

Additional details can be found in the project README file
