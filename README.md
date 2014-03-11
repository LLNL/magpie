magpie
======

Magpie contains a number of scripts for running Hadoop jobs in HPC
environments.  It currently supports the schedulers/resource managers
of Slurm and Moab.  It currently supports the parallel file system
Lustre and running over any generic network filesytem.  It supports
Hadoop extensions such as UDA.  It also supports other Hadoop
ecosystem software, such as Pig, Zookeeper, and Hbase.

Basic Idea
----------

The basic idea behind these scripts are to:

1) Allocate nodes on a cluster using your HPC scheduler/resource
   manager.  Slurm and Moab are currently supported.

2) Scripts will setup configuration files so the MPI rank 0 node is
   the "master".  All compute nodes will have configuration files
   created that point to the node designated as the jobtracker/yarn
   server.

   The Hadoop configuration files will be populated with values for
   your filesystem choice and the hardware that exists in your
   cluster.  Reasonable attempts are made to determine optimal values
   (they are almost certainly better than the default values for
   Hadoop).

3) Launch Hadoop daemons on all nodes.  The MPI rank 0 node will run
   the JobTracker/NameNode (or Yarn Server in Hadoop 2.0).  All
   remaining nodes will run DataNodes/Tasktrackers (or NodeManager in
   Hadoop 2.0).

4) Now you have a mini Hadoop cluster to do whatever you want.

Additional details can be found in the project README file
