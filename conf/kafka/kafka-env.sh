# Set Kafka environment variables here.

# The java implementation to use.  Java 1.6 required.
export JAVA_HOME=KAFKA_JAVA_HOME

# The directory where logs should go
export KAFKA_LOG_DIR="${KAFKA_LOG_DIR:-KAFKALOGDIR}"

# The directory where pid files are stored. /tmp by default.
export KAFKA_PID_DIR="${KAFKA_PID_DIR:-KAFKAPIDDIR}"

# The directory where configuration should go
export KAFKA_CONF_DIR="${KAFKA_CONF_DIR:-KAFKACONFDIR}"

# Log4j opts
export KAFKA_LOG4J_OPTS="${KAFKA_LOG4J_OPTS:-KAFKALOG4JOPTS} -Dlog4j.configuration=file:${KAFKA_CONF_DIR}/log4j.properties -Dkafka.logs.dir=${KAFKA_LOG_DIR}"

# GC Logging Opts
export LOG_DIR="${KAFKA_LOG_DIR:-KAFKALOGDIR}"
