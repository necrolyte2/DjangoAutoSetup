# Simple Django+Nginx Installer

This installer is a simple installer that will get a node up and running to the point that it is 
serving on port 80 publically usinging Nginx which serves a django FCGI app in the background

Setup assumes the machine is Ubuntu
Tested with 10.10 Maverick

# Setup

* Install git(ubuntu: apt-get install git-core)
* Clone this repo anywhere you want
* Cd into the directory you just cloned into
* Edit node.json and modify the name and location of your app
* bash setup.sh

# Notes

This setup uses chef-solo to do most of the work.
The node.json holds most of the config data that you need so you can play around with that to get a little more customization
