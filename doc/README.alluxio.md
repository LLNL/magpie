Instructions For Alluxio
------------------------

0) If necessary, download your favorite version of Alluxio and install
   it into a location where it's accessible on all cluster nodes.
   Usually this is on a NFS home directory.

   See below in 'Alluxio Patching' about patches that are necessary for
   correct Alluxio behavior. It is required when using Alluxio /bin scripts
   with configuration directory other than the default ${ALLUXIO_HOME}/conf
   (as Magpie does). This can be changed locally using ALLUXIO_CONF_DIR,
   but it would affect only the master where the start command is running,
   each worker looks for the configuration in the default directory. Applying
   patches allows you to set the configuration file to the entire cluster.

   See 'Convenience Scripts' in README about
   misc/magpie-download-and-setup.sh, which may make the
   downloading and patching easier.

1) Select an appropriate submission script for running your job. You
   can find them in the directory submission-scripts/, ex. Slurm
   Sbatch scripts using srun are in script-sbatch-srun. To use Alluxio
   in Magpie, it would be file magpie.sbatch-srun-alluxio or to use
   Spark with Alluxio file magpie.sbatch-srun-spark-with-alluxio.

   As Alluxio is predominantly a data caching service used by other
   services (e.g. Spark), it's likely in the main submission scripts
   for some of those big data projects. If the Alluxio section isn't
   in it, just copy the Alluxio section from base script
   (e.g. magpie.sbatch-srun) into it.

2) Setup your job essentials at the top of the submission script. See
   other projects (e.g. Spark in README.spark) for details on this
   setup.

3) Select how your job will run by setting MAGPIE_JOB_TYPE and/or
   ALLUXIO_JOB. Initially, you'll likely want to set MAGPIE_JOB_TYPE to
   'alluxio' and setting ALLUXIO_JOB to 'testalluxio'. This will allow
   you to run a pre-written job to make sure things are setup correctly.

4) Setup the essentials for Alluxio.

   ALLUXIO_SETUP : Set to yes

   ALLUXIO_VERSION : Set appropriately.

   ALLUXIO_HOME : Where your Alluxio code is. Typically in an NFS
   mount.

   ALLUXIO_WORKER_ON_MASTER : Most big data projects do not have
   a "worker" that also runs on the master node
   (such as Hadoop, Hbase, etc.). Alluxio is an exception in which
   it often likes to have a worker running on the master node
   for convenience of running tests and such. It is not required
   to run a worker on the master, but it can be convenient.
   Specify to "yes" to run a worker on the master.

   ALLUXIO_LOCAL_DIR : Path to store data local to each cluster node,
   typically something in /tmp. This will store local conf files
   and log files for your job.

   ALLUXIO_UNDER_FS_DIR : This should point to the path where you store
   your data and have to be accessible on all nodes in your allocation.
   Most likely it would be placed on lustre, like `"/lustre/${USER}/alluxio"`,
   but also it could be NFS mounted on all Alluxio nodes,
   like `"${ALLUXIO_HOME}/underFSStorage"`, or ex. HDFS,
   like `"hdfs://hdfsmaster:9000/alluxio/"`.
   Check Alluxio documentation for more UnderFS storage options.

   ALLUXIO_DATA_CLEAR : Alluxio has data files that are written to UnderFS
   and a journal file containing metadata so the state of Alluxio filesystem
   is saved and can be reused on multiple Alluxio runs. This flag enabled
   forces that data to be wiped which results in a clean install of Alluxio
   every time Magpie runs it. To keep data between runs, set to no.

   ALLUXIO_WORKER_MEMORY_SIZE : Set the amount of memory each Alluxio
   worker will use. Memory would be used as the first tier of storage.
   The more memory would Alluxio have, the bigger first tier storage would be.
   Be mindful of the memory requirements of other services (e.g. Spark).

   ALLUXIO_WORKER_TIER0_PATH : Alluxio will use RAM File System as caching storage.
   In this variable, there could be set path for tiered storage level 0.
   Default settings are /mnt/ramdisk on Linux and /Volumes/ramdisk on OSX.

      To avoid sudo requirement but using tmpFS in Linux,
      set here /dev/shm and ALLUXIO_RAMFS_MOUNT_OPTION to NoMount option.

   ALLUXIO_RAMFS_MOUNT_OPTION : Select option how RamFS should be
   mounted in Alluxio. In most cases, if you don't have sudo rights
   use the NoMount option.
   There are 3 mount options for alluxio-start.sh command:
   - `Mount` - Mount the configured RamFS if it is not already mounted.
   - `SudoMount` - Mount the configured RamFS using sudo
   if it is not already mounted. This option requires sudo,
   it should not be used when user doesn't have sudo rights.
   - `NoMount` - Do not mount the configured RamFS. Also, this option
   should be used when RamFS is not available.

      To avoid sudo requirement but using tmpFS in Linux,
      set ALLUXIO_WORKER_TIER0_PATH to /dev/shm and use here NoMount option.

   ALLUXIO_READ_TYPE : Default read type when creating Alluxio files.
   Valid options are:
   - `CACHE_PROMOTE` - move data to highest tier if already in Alluxio
   storage, write data into highest tier of local Alluxio if data needs
   to be read from under storage,
   - `CACHE` - write data into highest tier of local Alluxio if data needs
   to be read from under storage,
   - `NO_CACHE` - no data interaction with Alluxio, if the read is from Alluxio
   data migration or eviction will not occur.

      If you have doubts, leave the default value.

   ALLUXIO_WRITE_TYPE : Default write type when creating Alluxio files.
   Valid options are:
   - `MUST_CACHE` - write will only go to Alluxio and must be stored in Alluxio,
   - `CACHE_THROUGH` - try to cache, write to UnderFS synchronously,
   - `THROUGH` - no cache, write to UnderFS synchronously,
   - `ASYNC_THROUGH` - try to cache, write to UnderFS asynchronously.

      If you have doubts, leave the default value.

   ALLUXIO_JOB : Select job for Alluxio to be run
   if MAGPIE_JOB_TYPE=alluxio currently only "testalluxio" job
   is supported, which is basic sanity check.

   If you consider using more tiered storage levels than default 1,
   do it directly in file magpie/conf/alluxio/alluxio-site.properties.

5) Run your job as instructions dictate in other project sections
   (e.g. Spark in README.spark).

   Take note that it may be necessary to include the alluxio client
   jar in your jobs, as it may not be in the default paths. For
   example, with Spark you may need to add in the
   spark/conf/spark-defaults.conf these lines:

   spark.driver.extraClassPath   /<PATH_TO_ALLUXIO>/client/alluxio-2.3.0-client.jar
   spark.executor.extraClassPath /<PATH_TO_ALLUXIO>/client/alluxio-2.3.0-client.jar

   See "Exported Environment Variables" in README for information on
   common exported environment variables that may be useful in
   scripts.

   See below in "Alluxio Exported Environment Variables", for
   information on Alluxio specific exported environment variables that
   may be useful in scripts.

   See "General Advanced Usage" in README for additional tips.

Alluxio Exported Environment Variables
--------------------------------------

The following environment variables are exported when your job is run
and may be useful in scripts in your run or in pre/post run scripts.

ALLUXIO_CONF_DIR : the directory that Alluxio configuration files local
                   to the node are stored.

ALLUXIO_LOGS_DIR : the directory Alluxio log files are stored

ALLUXIO_MASTER_NODE : the master node of the Alluxio allocation. Often
                      used for accessing alluxio
                      (e.g. alluxio://${ALLUXIO_MASTER_NODE}:${ALLUXIO_MASTER_PORT})

ALLUXIO_MASTER_PORT : the master port for running Alluxio jobs. Often
                      used for accessing alluxio
                      (e.g. alluxio://${ALLUXIO_MASTER_NODE}:${ALLUXIO_MASTER_PORT})

ALLUXIO_WORKER_COUNT : number of compute/data nodes in your allocation
                      for Alluxio.

Alluxio Patching
----------------

- Patch to support alternate config file directories is required.
  Patch can be applied directly to startup scripts.

  The alternate remote execution command must be specified in the
  environment variable MAGPIE_REMOTE_CMD.
