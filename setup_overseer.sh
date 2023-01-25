#!/bin/bash

# basic xdg configuration
if [ "x$XDG_CONFIG_HOME" = "x" ] ; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

# load the user defined variables
if [ -f "~/.env" ]; then
    echo "> Load environment variables from ~/.env files"

    . ~/.env
fi

# load the user defined variables
if [ -f "./.env" ]; then
    echo "> Load environment variables from ./.env files"

    . .env
fi

# update the system for the first time
if [ "${UPDATE_SYSTEM}" = true ]; then
    echo "> Perform system update"
    sudo apt-get install -y software-properties-common
    sudo apt-get update -y;
    sudo apt-get upgrade -y;
    sudo rpi-update -y
fi

# install latest python version available
if [ "${INSTALL_PYTHON3}" = true ]; then
    echo "> Install Python3"
    sudo apt-get update -y;
    sudo apt-get install -y python3 python3-venv python3-pip python3-dev
fi

if [ "x$ALLOWED_SSH_KEY" == "x" ]; then
    echo ${$ALLOWED_SSH_KEY} >> ~/.ssh/
fi

# prepare private key
if [ "${GENERATE_PRIVATE_KEY}" = true ]; then
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        echo "> Generate private key for host"
        ssh-keygen -t ed25519 -q -C $USER@$HOSTNAME -f ~/.ssh/id_ed25519 -P -N

        ls -l ~/.ssh/id_ed25519*
    fi
fi

if [ "${REBOOT_AFTER_SETUP-false}" = true ]; then
    sudo reboot
fi