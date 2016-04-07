#!/bin/bash

add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
apt-get update
apt-get install skype
