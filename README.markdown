# Simple Django+Nginx Installer

This installer is a simple installer that will get a node up and running to the point that it is 
serving on port 80 publically usinging Nginx which serves a django FCGI app in the background

What you end up with in the end is

* Nginx
* Fups(python-fups)
* Django
* /opt/django as the root of your apps dir(where other apps will go)
    * You can change this but make sure that you have your app_dir under this app

Setup assumes the machine is Ubuntu
Tested with 10.10 Maverick

# Setup

* Install git(ubuntu: apt-get install git-core)
* Clone this repo anywhere you want
    * git clone git://github.com/necrolyte2/DjangoAutoSetup.git
* Cd into the directory you just cloned into
* Copy node.json.example to node.json
* Edit node.json
    * Change the base location of your apps
    * Modify the example app(you can add more too)
    * Enter in the git repo of your app. You don't have to do it, but it is a convinience thing)
        * NOTE: You will have to make sure to setup ssh keys for the git repos manually so they can connect
* bash setup.sh

# Notes

This setup uses chef-solo to do most of the work.
The node.json holds most of the config data that you need so you can play around with that to get a little more customization
