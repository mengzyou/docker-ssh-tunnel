#!/bin/bash

# check id_rsa
if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo "[Error] id_rsa file is not exist, please use -v id_rsa:/root/.ssh/id_rsa to bind the id_rsa file to the container."
  exit 1
fi

chmod 600 $HOME/.ssh/id_rsa

forword_str=""
IFS=',' read -r -a f_ports <<< "${SSH_REMOTE_FORWORD_PORTS}"
for port in "${f_ports[@]}"; do
  forword_str="${forword_str} -L 0.0.0.0:${port}:${SSH_REMOTE_FORWORD_IP}:${port}"
done

ssh_options_str="-p ${SSH_REMOTE_PORT} ${forword_str} ${SSH_REMOTE_USER}@${SSH_REMOTE_IP}"
# echo ${ssh_options_str}

if [ "$1" == "ssh" ]; then
  # ssh tunnel
  exec su-exec root ssh ${ssh_options_str}
else
  exec su-exec root $@
fi
