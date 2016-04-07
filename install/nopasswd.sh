#!/bin/bash

echo "$SUDO_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-cloudimg-ubuntu
