#!/bin/bash

########################
# Java8
########################
echo "Installing Java8"
sudo apt-get -y install software-properties-common > /dev/null 2>&1
sudo sh -c 'echo deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main > /etc/apt/sources.list.d/webupd8team-java.list'
sudo sh -c 'echo deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main >> /etc/apt/sources.list.d/webupd8team-java.list'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer > /dev/null 2>&1

########################
# Jenkins
########################
echo "Installing Jenkins"
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y install jenkins > /dev/null 2>&1

########################
# nginx
########################
echo "Installing nginx"
sudo apt-get -y install nginx > /dev/null 2>&1
sudo systemctl start nginx

########################
# Configuring nginx
########################
echo "Configuring nginx"
cd /etc/nginx/sites-available
sudo rm default ../sites-enabled/default
sudo cp /vagrant/VirtualHost/jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo systemctl restart nginx
sudo systemctl restart jenkins
echo "Success"
