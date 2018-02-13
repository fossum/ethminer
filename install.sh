sudo su

# Check for git and git-lfs

# Add miner user
adduser --system --no-create-home --disabled-password miner

# Get repo
cd /opt
git clone http://thefoss.net/ericfoss/ethminer.git

# Link service
cd /opt/ethminer/
ln -s /opt/ethminer/ethminer.service /etc/systemd/system/ethminer.service

# Start service
systemctl daemon-reload
systemctl enable ethminer
systemctl start ethminer
