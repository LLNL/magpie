# Set phoenix environment variables here.

# The java implementation to use.  Java 1.6 required.
export JAVA_HOME=PHOENIX_JAVA_HOME

# The directory where logs should go
export PHOENIX_LOG_DIR="${PHOENIX_LOG_DIR:-PHOENIXLOGDIR}"

# The directory where pid files are stored. /tmp by default.
export PHOENIX_PID_DIR="${PHOENIX_PID_DIR:-PHOENIXPIDDIR}"

# The directory where configuration should go
export PHOENIX_CONF_DIR="${PHOENIX_CONF_DIR:-PHOENIXCONFDIR}"

# Query server options
export PHOENIX_QUERYSERVER_OPTS="${PHOENIX_QUERYSERVER_OPTS:-PHOENIXQUERYSERVEROPTS} -Dlog4j.configuration=file:${PHOENIX_CONF_DIR}/log4j.properties -Dphoenix.root.loger=INFO,DRFA,console -Dphoenix.log.dir=${PHOENIX_LOG_DIR} -Dphoenix.log.file=phoenix-$(whoami)-$(hostname).log"
