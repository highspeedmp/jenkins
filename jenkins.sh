#!/bin/bash
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

if command -v puppet &> /dev/null; then
  echo "puppet is installed"
else
  apt install -y puppet
fi

# Here we download our .pp file from my github gist then do a puppet apply jenkins.pp
cd ~
wget -O jenkins.pp https://gist.githubusercontent.com/highspeedmp/8163ce1e16dd221497ed22a5217f311c/raw/8405020bdbdbac2333c4036b4068e2e439fce46c/jenkins.pp
puppet apply jenkins.pp
