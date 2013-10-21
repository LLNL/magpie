magpie
======

Magpie contains a number of scripts for running Hadoop jobs in HPC environments using Slurm and running jobs on top of Lustre

Basic Idea
==========

The basic idea behind these scripts are to:

1) Allocate nodes on a cluster using slurm

2) Scripts will setup configuration files so the Slurm/MPI rank 0 node
   is the "master".  All compute nodes will have configuration files
   created that point to the node designated as the jobtracker/yarn
   server.

   The Hadoop configuration files will be populated with values that
   are deemed optimal (or atleast pretty decent values better than the
   defaults) given your cluster hardware.

3) Launch Hadoop daemons on all nodes.  The Slurm/MPI rank 0 node will
   run the JobTracker/NameNode (or Yarn Server in Hadoop 2.0).  All
   remaining nodes will run DataNodes/Tasktrackers (or NodeManager in
   Hadoop 2.0).

Now you have a mini Hadoop cluster to do whatever you want.

Additional details can be found in the project README file