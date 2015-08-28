magpie
======

Magpie contains a number of scripts for running Big Data software in
HPC environments.  Thus far, Hadoop, Hbase, Pig, Spark, Storm,
Tachyon, and Zookeeper are supported.  It currently supports running
over the parallel file system Lustre and running over any generic
network filesytem.  There is scheduler/resource manager support for
Slurm, Moab, Torque, and LSF.

Basic Idea
----------

The basic idea behind these scripts are to:

1) Submit a job batch script to allocate nodes on a cluster using your
   HPC scheduler/resource manager.  Slurm, Moab+Slurm, Moab+Torque and
   LSF are currently supported.

2) The batch script will create configuration files for all
   appropriate projects (Hadoop, Hbase, etc.)  The configuration files
   will be setup so the rank 0 node is the "master".  All compute
   nodes will have configuration files created that point to the node
   designated as the master server.

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

Requirements
------------

1) Magpie and all big data projects (Hadoop, Spark, etc.) should be
   installed on all cluster nodes.  It can be in a known location or
   perhaps via a network file system location.  Many users may simply
   install them into their NFS home directories.

   These paths will be specified in job submission scripts.

2) A passwordless remote shell execution mechanism must be available
   for scripts to launch big data daemons (Hadoop Datanodes, Hbase
   Regionservers, etc.) on all appropriate nodes.  The most popular
   (and default mechanism) is passwordless ssh.  However, other
   mechanisms are more than suitable.

3) A temporary local scratch space is needed on each node for Magpie
   to store configuration files, log files, and other miscellaneous
   files.  A very small amount of scratch space is needed.

   This local scratch space need not be a local disk.  It could
   hypothetically be memory based tmpfs.

   Beginning with Magpie 1.60 the ability to use network file paths
   for "local scratch" space was supported, but requires some extra
   work.  See README.no-local-dir for details.

4) A minor set of software dependencies are required depending on your
   environment.

   The Moab+Torque submission scripts use Pdsh
   (https://code.google.com/p/pdsh/) to launch/run scripts across
   cluster nodes.

   The LSF submission scripts use mpirun to launch/run scripts across
   cluster nodes.

   The 'hostlist' command from lua-hostlist
   (https://github.com/grondo/lua-hostlist) is preferred for a variety
   of hostrange parsing needs in Magpie.  If it is not available,
   Magpie will use its internal tool 'magpie-expand-nodes', which
   should be sufficient for most hostrange parsing, but may not
   function for a number of nuanced corner cases.

Local Configuration
-------------------

All HPC sites will have local differences and nuances to running jobs.
The job submission scripts in submission-scripts/ have a number of
defaults, such as the default location for network file systems, local
scratch space, etc.

You can adjust these defaults by editing the defaults listed in
submission-scripts/script-templates/Makefile and running 'make'
afterwards.

In addition, if your site requires local special requirements, such as
setting unique paths or loading specific modules before executing a
job, this can also be configured via the LOCAL_REQUIREMENTS
configuration in the same Makefile.

Supported Package Versions
--------------------------

The following packages have been tested for minimal support in Magpie.
Versions not listed below should work with Magpie if the
configuration/setup of those versions is compatible with the versions
listed below.

* + - Requires patch against binary distro's scripts, no re-compilation needed
* ^ - Requires patch against source, requires re-compilation

Hadoop - 1.2.1+, 2.1.0-beta+, 2.2.0+, 2.4.0+, 2.6.0+, 2.7.1+

Pig - 0.12.0, 0.12.1, 0.14.0, 0.15.0

Hbase - 0.96.1.1-hadoop2+, 0.98.3-hadoop2+, 0.98.9-hadoop2+

Spark - 0.9.1-bin-hadoop2+, 1.0.0-bin-hadoop2^, 1.2.0-bin-hadoop2.4+, 1.3.0-bin-hadoop2.4+,
        1.4.1-bin-hadoop2.6

Storm - 0.9.2^, 0.9.3, 0.9.4, 0.9.5

Zookeeper - 3.4.5, 3.4.6

UDA/uda-plugin - 3.3.2-0

Tachyon - 0.6.0+, 0.6.1+ [1]

[1] - Default Tachyon build is against Hadoop 1.0.4 and Spark may be
      built against non-0.6.X builds.  Recompilation of Tachyon &
      Spark may be needed depending on your environment.  See README
      for more details

