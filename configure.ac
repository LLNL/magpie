AC_INIT(magpie)

AC_ARG_ENABLE([intel-lustre],
	      [ --enable-intel-lustre            Enable inclusion of Intel Lustre adapter],
	      [intel_lustre=${enable_val}],
	      [intel_lustre=no])
AC_SUBST(INTELLUSTRE, ${intel_lustre})

AC_ARG_ENABLE([magpie-networkfs],
	      [ --enable-magpie-networkfs        Enable inclusion of Magpie Networkfs],
	      [magpie_networkfs=${enable_val}],
	      [magpie_networkfs=no])
AC_SUBST(MAGPIENETWORKFS, ${magpie_networkfs})

AC_ARG_ENABLE([hdfs-over-networkfs],
	      [ --disable-hdfs-over-networkfs    Disable HDFS over network filesystem],
	      [hdfs_over_networkfs=${enable_val}],
	      [hdfs_over_networkfs=yes])
AC_SUBST(HDFSOVERNETWORKFS, ${hdfs_over_networkfs})

AC_ARG_ENABLE([hdfs_federation],
	      [ --enable-hdfs-federation         Enable federation of HDFS],
	      [hdfs_federation=${enable_val}],
	      [hdfs_federation=no])
AC_SUBST(HDFS_FEDERATION, ${hdfs_federation})

## Environement variables.
AC_ARG_VAR([JAVA_HOME], [location of Java Development Kit (JDK)])
AC_ARG_VAR([HOME_DIR], [   User home directory path])
AC_ARG_VAR([PROJECT_DIR], [   Apache software ecosystem installation path])
AC_ARG_VAR([LOCAL_DIR], [     Node local filesystem])
AC_ARG_VAR([LUSTRE_DIR], [    User lustre scratch directory path])
AC_ARG_VAR([SSD_DIR], [       User SSD directory path])
AC_ARG_VAR([NETWORKFS_DIR], [ User network filesystem directory path])

# Default variable values.
if test "x${LUSTRE_DIR}" = "x"; then
	LUSTRE_DIR='/lustre/${USER}'
fi
if test "x${LOCAL_DIR}" = "x"; then
	LOCAL_DIR='/tmp/${USER}'
fi
if test "x${PROJECT_DIR}" = "x"; then
	PROJECT_DIR='${HOME}'
fi
if test "x${HOME_DIR}" = "x"; then
	HOME_DIR='${HOME}'
fi
if test "x${NETWORKFS_DIR}" = "x"; then
	NETWORKFS_DIR='/networkfs/${USER}'
fi
if test "x${SSD_DIR}" = "x"; then
	SSD_DIR='/ssd/${USER}'
fi

# Escape dollar signs in variables.
LUSTRE_DIR=${LUSTRE_DIR/'$'/'$$'}
SSD_DIR=${SSD_DIR/'$'/'$$'}
NETWORKFS_DIR=${NETWORKFS_DIR/'$'/'$$'}
LOCAL_DIR=${LOCAL_DIR/'$'/'$$'}
PROJECT_DIR=${PROJECT_DIR/'$'/'$$'}
HOME_DIR=${HOME_DIR/'$'/'$$'}

# Write results.
AC_OUTPUT([submission-scripts/script-templates/Makefile])

