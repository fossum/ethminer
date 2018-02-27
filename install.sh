#!/usr/bin/bash

# Check for git and git-lfs

# Add miner user
id -u miner > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "Adding miner user for service"
  sudo adduser --system --no-create-home --disabled-password miner
fi

# Get repo
cd /opt
if [ -d /opt/ethminer ]
then
  echo "Pulling latest Git repo changes"
  cd ethminer
  git pull
else
  echo "Cloning ethminer repo"
  git clone http://thefoss.net/ericfoss/ethminer.git
fi

# Link service
cd /opt/ethminer/
if [ -f /opt/systemd/system/ethminer ]
then
  echo "Removing existing ethminer service"
  sudo systemctl stop ethminer
  sudo systemctl disable ethminer
fi
echo "Creating systemd service file"
sudo cp --remove-destination --force /opt/ethminer/ethminer.service /lib/systemd/system/

# Start service
if [ -f /lib/systemd/system/ethminer.service ]
then
  echo "Enabling and starting the service"
  sudo systemctl daemon-reload
  sudo systemctl enable ethminer
  sudo systemctl start ethminer
  echo "You can now check the service with 'sudo systemctl status ethminer'"
fi
