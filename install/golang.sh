#!/bin/bash

set -x

cd /tmp
wget --no-verbose https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.6.linux-amd64.tar.gz
