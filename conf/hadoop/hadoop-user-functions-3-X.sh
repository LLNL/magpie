#!/usr/bin/env bash

## hadoop_connect_to_hosts, identical to original except checks for
## MAGPIE_NO_LOCAL_DIR.  Can't use pdsh with NO_LOCAL_DIR

## @description  Connect to ${HADOOP_WORKERS} or ${HADOOP_WORKER_NAMES}
## @description  and execute command.
## @audience     private
## @stability    evolving
## @replaceable  yes
## @param        command
## @param        [...]
function hadoop_connect_to_hosts
{
  # shellcheck disable=SC2124
  local params="$@"
  local worker_file
  local tmpslvnames
  local myhostname=`hostname`
  local hadoopconfdirval=`echo ${HADOOP_CONF_DIR} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/"`

  #
  # ssh (or whatever) to a host
  #
  # User can specify hostnames or a file where the hostnames are (not both)
  if [[ -n "${HADOOP_WORKERS}" && -n "${HADOOP_WORKER_NAMES}" ]] ; then
    hadoop_error "ERROR: Both HADOOP_WORKERS and HADOOP_WORKER_NAME were defined. Aborting."
    exit 1
  elif [[ -z "${HADOOP_WORKER_NAMES}" ]]; then
    if [[ -n "${HADOOP_WORKERS}" ]]; then
      worker_file=${HADOOP_WORKERS}
    elif [[ -f "${hadoopconfdirval}/workers" ]]; then
      worker_file=${hadoopconfdirval}/workers
    elif [[ -f "${hadoopconfdirval}/slaves" ]]; then
      hadoop_error "WARNING: 'slaves' file has been deprecated. Please use 'workers' file instead."
      worker_file=${hadoopconfdirval}/slaves
    fi
  fi

  # if pdsh is available, let's use it.  otherwise default
  # to a loop around ssh.  (ugh)
  if [[ -e '/usr/bin/pdsh' && "${MAGPIE_NO_LOCAL_DIR}" != "yes" ]]; then
    if [[ -z "${HADOOP_WORKER_NAMES}" ]] ; then
      # if we were given a file, just let pdsh deal with it.
      # shellcheck disable=SC2086
      PDSH_SSH_ARGS_APPEND="${HADOOP_SSH_OPTS}" pdsh \
      -f "${HADOOP_SSH_PARALLEL}" -w ^"${worker_file}" $"${@// /\\ }" 2>&1
    else
      # no spaces allowed in the pdsh arg host list
      # shellcheck disable=SC2086
      tmpslvnames=$(echo ${HADOOP_WORKER_NAMES} | tr -s ' ' ,)
      PDSH_SSH_ARGS_APPEND="${HADOOP_SSH_OPTS}" pdsh \
        -f "${HADOOP_SSH_PARALLEL}" \
        -w "${tmpslvnames}" $"${@// /\\ }" 2>&1
    fi
  else
    if [[ -z "${HADOOP_WORKER_NAMES}" ]]; then
      HADOOP_WORKER_NAMES=$(sed 's/#.*$//;/^$/d' "${worker_file}")
    fi
    hadoop_connect_to_hosts_without_pdsh "${params}"
  fi
}

## hadoop_connect_to_hosts_without_pdsh - similar to original but
## handles MAGPIE_NO_LOCAL_DIR if hostname substitution is necessary.

## @description  Connect to ${HADOOP_WORKER_NAMES} and execute command
## @description  under the environment which does not support pdsh.
## @audience     private
## @stability    evolving
## @replaceable  yes
## @param        command
## @param        [...]
function hadoop_connect_to_hosts_without_pdsh
{
  # shellcheck disable=SC2124
  local params="$@"
  local workers=(${HADOOP_WORKER_NAMES})
  for (( i = 0; i < ${#workers[@]}; i++ ))
  do
    if (( i != 0 && i % HADOOP_SSH_PARALLEL == 0 )); then
      wait
    fi
    # shellcheck disable=SC2086
    thisparams=`echo ${params} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/${workers[$i]}/"`
    hadoop_actual_ssh "${workers[$i]}" ${thisparams} &
  done
  wait
}

## hadoop_actual_ssh - similar to original but checks for
## HADOOP_SSH_CMD to see if an alternate remote command should be
## used.

## @description  Via ssh, log into `hostname` and run `command`
## @audience     private
## @stability    evolving
## @replaceable  yes
## @param        hostname
## @param        command
## @param        [...]
function hadoop_actual_ssh
{
  # we are passing this function to xargs
  # should get hostname followed by rest of command line
  local worker=$1
  shift

  local SSH_CMD=${HADOOP_SSH_CMD:-ssh}

  # shellcheck disable=SC2086
  ${SSH_CMD} ${HADOOP_SSH_OPTS} ${worker} $"${@// /\\ }" 2>&1 | sed "s/^/$worker: /"
}
