#!/usr/bin/bash

debug=""

if [ "$1" == "-v" ]
then
	debug="-l debug"
fi

# Install chef
if [ ! -f /etc/apt/sources.list.d/opscode.list ]
then
	echo "deb http://apt.opscode.com/ `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/opscode.list
	wget -qO - http://apt.opscode.com/packages@opscode.com.gpg.key | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y install chef
	sudo killall chef-client
fi

# Make sure the directory for the cookbooks exists
sudo cp -R cookbooks /var/lib/chef/

# Copy the node.json over
sudo cp node.json /var/tmp/node.json

# Copy chef solo config
sudo cp solo.rb /etc/chef/solo.rb

# Run Chef Solo
sudo chef-solo ${debug}
