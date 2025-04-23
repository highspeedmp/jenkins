#!/bin/bash

# Make sure the script is being run by the root user
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi
# Check for prerequisites, pull down installer script
# not sure if we will use curl for single file, or pull down a git repo for this
if command -v curl &> /dev/null; then
  echo "curl is installed"
else
  apt install -y curl
fi

if command -v git &> /dev/null; then
  echo "git is installed"
else
  apt install -y git
fi
if command -v puppet &> /dev/null; then
  echo "puppet is installed"
else
  apt install -y puppet
fi

# Here we download our .pp file then do a puppet apply jenkins.pp
