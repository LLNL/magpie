#!/usr/bin/env bash

## hadoop_actual_ssh - similar to original but checks for
## HADOOP_SSH_CMD to see if an alternate remote command should be used

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
