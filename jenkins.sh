#!/bin/bash
# 
# Install Jenkins via puppet
# This script checks for prerequisites, installs the puppet agent
# and pulls down the puppet agent configuration file

# Make sure the script is being run by the root user
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi
# wget is installed in the base Ubuntu 22.04 install, double check anyway
if command -v wget &> /dev/null; then
  echo "wget is installed"
else
  apt install -y wget
fi
# install the puppet agent, if not already present
if command -v puppet &> /dev/null; then
  echo "puppet is installed"
else
  apt install -y puppet
fi

# Here we download our .pp file and the modified systemd unit file for jenkins from my github repo 
# then do a puppet apply jenkins.pp
cd ~
wget -O jenkins.pp https://raw.githubusercontent.com/highspeedmp/jenkins/refs/heads/main/jenkins.pp
wget -O jenkins.service https://raw.githubusercontent.com/highspeedmp/jenkins/refs/heads/main/jenkins.service

puppet apply jenkins.pp
