magpie
======

This project contains a number of scripts for running Big Data
software in HPC environments.  Thus far, Hadoop, Hbase, Pig, Spark,
Storm, Tachyon, and Zookeeper are supported.  It currently supports
running over the schedulers of Slurm and Moab, and the resource
managers of Slurm and Torque.  It currently supports running over the
parallel file system Lustre and running over any generic network
filesytem.

Basic Idea
----------

The basic idea behind these scripts are to:

1) Allocate nodes on a cluster using your HPC scheduler/resource
   manager.  Slurm and Moab are currently supported.

2) Scripts will create configuration files for all appropriate
   projects (Hadoop, Hbase, etc.)  The configuration files will be
   setup so the rank 0 node is the "master".  All compute nodes will
   have configuration files created that point to the node designated
   as the master server.

   The configuration files will be populated with values for your
   filesystem choice and the hardware that exists in your cluster.
   Reasonable attempts are made to determine optimal values for your
   system and hardware (they are almost certainly better than the
   default values).  A number of options exist to adjust these values
   for individual jobs.

3) Launch daemons on all nodes.  The rank 0 node will run master
   daemons, such as the Hadoop Namenode or the Hbase Master.  All
   remaining nodes will run appropriate slave daemons, such as the
   Hadoop Datanodes or Hbase RegionServers.

4) Now you have a mini big data cluster to do whatever you want.  You
   can log into the master node and interact with your mini big data
   cluster however you want.  Or you could have Magpie run a script to
   execute your big data calculation instead.

5) When your job completes or your allocation time has run out, Magpie
   will cleanup your job by tearing down daemons.  When appropriate,
   Magpie may also do some additional cleanup work to hopefully make
   re-execution on later runs cleaner and faster (e.g. Hbase
   compaction).

Additional details can be found in the project README file
